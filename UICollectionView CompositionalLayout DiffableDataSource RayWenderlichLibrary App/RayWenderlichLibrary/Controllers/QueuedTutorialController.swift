/// These materials have been reviewed and are updated as of September, 2020
///
/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
///

import UIKit

class QueuedTutorialController: UIViewController {
  
  enum QueuedSection: String, CaseIterable {
    case main
  }
  
  lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d"
    return formatter
  }()
  
  @IBOutlet var deleteButton: UIBarButtonItem!
  @IBOutlet var updateButton: UIBarButtonItem!
  @IBOutlet var applyUpdatesButton: UIBarButtonItem!
  @IBOutlet weak var collectionView: UICollectionView!
  
  var dataSource: UICollectionViewDiffableDataSource<QueuedSection, Tutorial>!
  
  var timer: Timer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Queue"
    navigationController?.navigationBar.titleTextAttributes = [
      NSAttributedString.Key.font: UIFont(name: "American Typewriter", size: 24)!
    ]
    navigationItem.leftBarButtonItem = editButtonItem
    navigationItem.rightBarButtonItem = nil
    collectionView.collectionViewLayout = configureCollectionViewLayout()
    configureCollectionViewDataSource()
    collectionView.register(BadgeSupplementaryView.self, forSupplementaryViewOfKind: BadgeSupplementaryView.kind, withReuseIdentifier: BadgeSupplementaryView.reuseId)
    collectionView.allowsSelection = false
    collectionView.allowsMultipleSelection = false
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let queuedTutorials = DataRepository.shared.queuedTutorials
    var snapshot = NSDiffableDataSourceSnapshot<QueuedSection, Tutorial>()
    snapshot.appendSections(QueuedSection.allCases)
    snapshot.appendItems(queuedTutorials, toSection: .main)
    dataSource.apply(snapshot, animatingDifferences: false)
  }
  
}


// MARK: - Queue Events -
extension QueuedTutorialController {
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    
    collectionView.allowsSelection = editing
    collectionView.allowsMultipleSelection = editing
    
    if editing {
      navigationItem.rightBarButtonItems = nil
      navigationItem.rightBarButtonItem = deleteButton
      
    } else {
      navigationItem.rightBarButtonItem = nil
      navigationItem.rightBarButtonItems = [self.applyUpdatesButton, self.updateButton]
    }
    
    collectionView.indexPathsForVisibleItems.forEach { indexPath in
      guard let cell = collectionView.cellForItem(at: indexPath) as? QueueCell else { return }
      cell.isEditing = editing
    }
    
    if !editing {
      if let selectedIndexPaths = collectionView.indexPathsForSelectedItems {
        selectedIndexPaths.forEach {
          collectionView.cellForItem(at: $0)?.isSelected = false
        }
      }
    }
  }
  
  @IBAction func deleteSelectedItems() {
    guard let selectedIndexPaths = collectionView.indexPathsForSelectedItems else { return }
    var modifiedSnapshot = dataSource.snapshot()
    selectedIndexPaths.forEach {
      if let item = dataSource.itemIdentifier(for: $0) {
        item.isQueued.toggle()
        item.updateCount = 0
        modifiedSnapshot.deleteItems([item])
      }
    }
    dataSource.apply(modifiedSnapshot, animatingDifferences: true)
    isEditing.toggle()
  }
  
  @IBAction func triggerUpdates() {
      let visibleIndexPaths = collectionView.indexPathsForVisibleItems
      let randomIndex = Int.random(in: 0..<visibleIndexPaths.count)
      let randomlySelectedIndexPath = visibleIndexPaths[randomIndex]
    
      guard let tutorial = dataSource.itemIdentifier(for: randomlySelectedIndexPath) else { return }
    
      guard let badgeSupplementaryView = collectionView.supplementaryView(forElementKind: BadgeSupplementaryView.kind, at: randomlySelectedIndexPath) as? BadgeSupplementaryView else { return }
      tutorial.updateCount = 3
      badgeSupplementaryView.isHidden = tutorial.updateCount > 0 ? false : true
  }
  
  @IBAction func applyUpdates() {
    
    let tutorials = dataSource.snapshot().itemIdentifiers
    guard !tutorials.isEmpty else { return }
    guard var firstTutorial = tutorials.first else { return }
    
    let tutorialsWithUpdates = tutorials.filter { $0.updateCount > 0 }
    guard !tutorialsWithUpdates.isEmpty else { return }
    
    var snapshot = dataSource.snapshot()
    
    tutorialsWithUpdates.forEach { tutorial in
      if tutorial != firstTutorial {
        snapshot.moveItem(tutorial, beforeItem: firstTutorial)
        firstTutorial = tutorial
      }
      
      tutorial.updateCount = 0
      if let indexPathOfTutorial = dataSource.indexPath(for: tutorial) {
        if let badgeView = collectionView.supplementaryView(forElementKind: BadgeSupplementaryView.kind, at: indexPathOfTutorial) {
          badgeView.isHidden = true
        }
      }
    }
    
    dataSource.apply(snapshot)
  }
  
}


// MARK: - UICollectionView Configuration for Layout and DataSource
extension QueuedTutorialController {
  
  func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      guard let self = self else { return nil }
      
      let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20.0), heightDimension: .absolute(20.0))
      let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], absoluteOffset: CGPoint(x: 0.3, y: -0.3))
      let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: BadgeSupplementaryView.kind, containerAnchor: badgeAnchor)
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [badge])
      
      item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
      let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.collectionView.bounds.size.width), heightDimension: .absolute(148))
      let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
      return section
    }
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
  
  func configureCollectionViewDataSource() {
    dataSource = UICollectionViewDiffableDataSource<QueuedSection, Tutorial>(collectionView: self.collectionView) { [weak self] collectionView, indexPath, tutorial in
      guard let self = self else { fatalError() }
      guard let queueCell = collectionView.dequeueReusableCell(withReuseIdentifier: QueueCell.reuseId, for: indexPath) as? QueueCell else { fatalError() }
      queueCell.titleLabel.text = tutorial.title
      queueCell.publishDateLabel.text = tutorial.formattedDate(using: self.dateFormatter)
      queueCell.thumbnailImageView.layer.cornerRadius = 8
      queueCell.thumbnailImageView.clipsToBounds = true
      queueCell.thumbnailImageView.image = tutorial.image
      queueCell.thumbnailImageView.backgroundColor = tutorial.imageBackgroundColor
      queueCell.isEditing = self.isEditing
      return queueCell
    }
    
    dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
      guard let self = self else { return nil }
      
      if kind == BadgeSupplementaryView.kind {
        guard let tutorial = self.dataSource.itemIdentifier(for: indexPath) else { return nil }
        guard let badgeSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: BadgeSupplementaryView.kind, withReuseIdentifier: BadgeSupplementaryView.reuseId, for: indexPath) as? BadgeSupplementaryView else { return nil }
        
        badgeSupplementaryView.isHidden = tutorial.updateCount > 0 ? false : true
        return badgeSupplementaryView
      }
      else {
        return nil
      }
    }
    
    let queuedTutorials = DataRepository.shared.queuedTutorials
    var snapshot = NSDiffableDataSourceSnapshot<QueuedSection, Tutorial>()
    snapshot.appendSections(QueuedSection.allCases)
    snapshot.appendItems(queuedTutorials, toSection: .main)
    dataSource.apply(snapshot, animatingDifferences: false)
  }
  
}
