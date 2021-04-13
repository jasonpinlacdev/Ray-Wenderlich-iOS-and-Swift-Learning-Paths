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
  
  @IBOutlet var deleteButton: UIBarButtonItem!
  @IBOutlet var updateButton: UIBarButtonItem!
  @IBOutlet var applyUpdatesButton: UIBarButtonItem!
  @IBOutlet weak var collectionView: UICollectionView!
  
  var diffableDataSource: QueuedTutorialDiffableDataSource!
  
  lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d"
    return formatter
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    collectionView.register(BadgeSupplementaryView.self, forSupplementaryViewOfKind: BadgeSupplementaryView.kind, withReuseIdentifier: BadgeSupplementaryView.reuseId)
    collectionView.collectionViewLayout = configureCompositionalLayout()
    configureDiffableDataSource()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    diffableDataSource.update(animatingDifferences: false)
  }
  
  private func setupView() {
    self.title = "Queue"
    navigationItem.leftBarButtonItem = editButtonItem
    navigationItem.rightBarButtonItem = nil
  }
  
}

// MARK: - Queue Events -
extension QueuedTutorialController {
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    
    if isEditing {
      navigationItem.rightBarButtonItems = nil
      navigationItem.rightBarButtonItem = deleteButton
    } else {
      navigationItem.rightBarButtonItem = nil
      navigationItem.rightBarButtonItems = [self.applyUpdatesButton, self.updateButton]
    }
    
    collectionView.allowsMultipleSelection = true
    collectionView.indexPathsForVisibleItems.forEach { indexPath in
      guard let cell = collectionView.cellForItem(at: indexPath) as? QueueCell else { return }
      cell.isEditing = isEditing
      
      if !isEditing {
        cell.isSelected = false
      }
    }
  }
  
  @IBAction func deleteSelectedItems() {
    guard let selectedIndexPaths = collectionView.indexPathsForSelectedItems else { return }
    let tutorials = selectedIndexPaths.compactMap { indexPath in
      diffableDataSource.itemIdentifier(for: indexPath)
    }
    var currentSnapshot = diffableDataSource.snapshot()
    currentSnapshot.deleteItems(tutorials)
    diffableDataSource.apply(currentSnapshot)
    isEditing.toggle()
    
    tutorials.forEach {
      $0.updateCount = 0
      $0.isQueued.toggle()
    }
  }
  
  @IBAction func triggerUpdates() {
    let indexPaths = collectionView.indexPathsForVisibleItems
    let randomlyChosenIndexPath = indexPaths[Int.random(in: 0..<indexPaths.count)]
    
    if let tutorial = diffableDataSource.itemIdentifier(for: randomlyChosenIndexPath),
       let badgeView = collectionView.supplementaryView(forElementKind: BadgeSupplementaryView.kind, at: randomlyChosenIndexPath) {
      tutorial.updateCount = 3
      badgeView.isHidden = false
    }
  }
  
  @IBAction func applyUpdates() {
    let tutorials = diffableDataSource.snapshot().itemIdentifiers
    if var firstTutorial = tutorials.first,
       tutorials.count > 1 {
      
      var currentSnapshot = diffableDataSource.snapshot()
      let tutorialsWithUpdates = tutorials.filter{ $0.updateCount > 0}
      
      tutorialsWithUpdates.forEach { tutorial in
        if tutorial != firstTutorial {
          currentSnapshot.moveItem(tutorial, beforeItem: firstTutorial)
          firstTutorial = tutorial
          tutorial.updateCount = 0
        }
        
        if let indexPathOfTutorial = diffableDataSource.indexPath(for: tutorial),
           let badgeView = collectionView.supplementaryView(forElementKind: BadgeSupplementaryView.kind, at: indexPathOfTutorial) {
          badgeView.isHidden = true
        }
        
      }
      diffableDataSource.apply(currentSnapshot, animatingDifferences: true)
    }
  }
  
  
}

// MARK: - CollectionView Configuration -
extension QueuedTutorialController {
  
  func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
    let padding: CGFloat = 10.0
    
    let anchorEdges: NSDirectionalRectEdge = [.top, .trailing]
    let offset = CGPoint(x: 0.3, y: -0.3)
    let badgeAnchor = NSCollectionLayoutAnchor(edges: anchorEdges, fractionalOffset: offset)
    
    let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20), heightDimension: .absolute(20))
    let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: BadgeSupplementaryView.kind, containerAnchor: badgeAnchor)
    
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [badge])
    item.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(148.0))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    return UICollectionViewCompositionalLayout(section: section)
  }
  
  func configureDiffableDataSource() {
    diffableDataSource = QueuedTutorialDiffableDataSource(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, tutorial) -> UICollectionViewCell? in
      guard let queueCell = collectionView.dequeueReusableCell(withReuseIdentifier: QueueCell.reuseId, for: indexPath) as? QueueCell else { fatalError("Failed to dequeue reusable QueueCell.") }
      queueCell.titleLabel.text = tutorial.title
      queueCell.publishDateLabel.text = tutorial.formattedDate(using: self.dateFormatter)
      queueCell.thumbnailImageView.image = tutorial.image
      queueCell.thumbnailImageView.backgroundColor = tutorial.imageBackgroundColor
      return queueCell
    })
    
    diffableDataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) -> UICollectionReusableView? in
      guard let self = self,
            let badgeSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BadgeSupplementaryView.reuseId, for: indexPath) as? BadgeSupplementaryView,
            let tutorial = self.diffableDataSource.itemIdentifier(for: indexPath)
      else { return nil }
      
      badgeSupplementaryView.isHidden = tutorial.updateCount > 0 ? false : true
      return badgeSupplementaryView
      
    }
    
    diffableDataSource.update(animatingDifferences: false)
  }
  
  
  
}


