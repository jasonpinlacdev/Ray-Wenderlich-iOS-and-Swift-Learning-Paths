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

final class TutorialDetailViewController: UIViewController {
  
  private let tutorial: Tutorial
  
  @IBOutlet weak var tutorialCoverImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var publishDateLabel: UILabel!
  @IBOutlet weak var queueButton: UIButton!
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var dataSource: UICollectionViewDiffableDataSource<Section, Video>!
  
  init?(coder: NSCoder, tutorial: Tutorial) {
    self.tutorial = tutorial
    super.init(coder: coder)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d"
    return formatter
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let buttonTitle = tutorial.isQueued ? "Remove from queue" : "Add to queue"
    
    UIView.performWithoutAnimation { [weak self] in
      guard let self = self else { return }
      self.queueButton.setTitle(buttonTitle, for: .normal)
      self.queueButton.layoutIfNeeded()
    }

  }
  
  private func setupView() {
    self.title = tutorial.title
    tutorialCoverImageView.image = tutorial.image
    tutorialCoverImageView.backgroundColor = tutorial.imageBackgroundColor
    titleLabel.text = tutorial.title
    publishDateLabel.text = tutorial.formattedDate(using: dateFormatter)
    let buttonTitle = tutorial.isQueued ? "Remove from queue" : "Add to queue"
    queueButton.setTitle(buttonTitle, for: .normal)
   
    collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseId)
    collectionView.collectionViewLayout = configureLayout()
    configureDataSource()
  }
  
  @IBAction func toggleQueued() {
    tutorial.isQueued.toggle()
    
    UIView.performWithoutAnimation {
      if tutorial.isQueued {
        queueButton.setTitle("Remove from queue", for: .normal)
      } else {
        queueButton.setTitle("Add to queue", for: .normal)
      }
      
      self.queueButton.layoutIfNeeded()
    }
  }
  
  func configureLayout() -> UICollectionViewCompositionalLayout {
    let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44.0))
      let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
      let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44.0))
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
      let section = NSCollectionLayoutSection(group: group)
      section.boundarySupplementaryItems = [sectionHeader]
      return section
    }
    
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Video>(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, video in
      guard let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCell.reuseId, for: indexPath) as? ContentCell else { fatalError()}
      contentCell.textLabel.text = video.title
      return contentCell
    })
    
    dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
      guard let titleSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleSupplementaryView.reuseId, for: indexPath) as? TitleSupplementaryView else { return nil }
      titleSupplementaryView.titleLabel.textColor = .systemRed
      titleSupplementaryView.titleLabel.text = self?.dataSource.snapshot().sectionIdentifiers[indexPath.section].title
      return titleSupplementaryView
    }
    
    var snapshot = NSDiffableDataSourceSnapshot<Section, Video>()
    snapshot.appendSections(tutorial.content)
    tutorial.content.forEach {
      snapshot.appendItems($0.videos, toSection: $0)
    }
    dataSource.apply(snapshot)
  }
  
  
  
  
  
}
