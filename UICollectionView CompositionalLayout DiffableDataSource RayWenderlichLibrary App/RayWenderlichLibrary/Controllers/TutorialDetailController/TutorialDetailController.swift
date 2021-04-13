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
  static let reuseId = String(describing: TutorialDetailViewController.self)
  
  private let tutorial: Tutorial
  
  var diffableDataSource: TutorialDetailDiffableDataSource!
  
  @IBOutlet weak var tutorialCoverImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var publishDateLabel: UILabel!
  @IBOutlet weak var queueButton: UIButton!
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  // custom init?(coder: NSCoder, ...) is new to iOS13+
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
    collectionView.register(SectionHeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderSupplementaryView.reuseId)
    collectionView.collectionViewLayout = configureCompositionalLayout()
    configureDiffableDataSource()

  }
  
  override func viewWillAppear(_ animated: Bool) {
    UIView.performWithoutAnimation {
      queueButton.setTitle(tutorial.isQueued ? "Remove from queue" : "Add to queue", for: .normal)
    }
  }
  
  private func setupView() {
    self.title = tutorial.title
    tutorialCoverImageView.image = tutorial.image
    tutorialCoverImageView.backgroundColor = tutorial.imageBackgroundColor
    titleLabel.text = tutorial.title
    publishDateLabel.text = tutorial.formattedDate(using: dateFormatter)
    collectionView.layer.cornerRadius = 10
    
    let buttonTitle = tutorial.isQueued ? "Remove from queue" : "Add to queue"
    queueButton.setTitle(buttonTitle, for: .normal)
  }
  
  @IBAction func toggleQueued() {
    self.tutorial.isQueued.toggle()
    UIView.performWithoutAnimation {
      queueButton.setTitle(tutorial.isQueued ? "Remove from queue" : "Add to queue", for: .normal)
      self.queueButton.layoutIfNeeded()
    }
  }
  
}

// MARK: - CollectionView Configuration -

extension TutorialDetailViewController {
  func configureDiffableDataSource() {
    diffableDataSource = TutorialDetailDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, video) -> UICollectionViewCell? in
      guard let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.reuseId, for: indexPath) as? VideoCell else { fatalError("Failed to dequeue reuasbale VideoCell.") }
      videoCell.titleLabel.text = video.title
      return videoCell
    })
    
    diffableDataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) -> UICollectionReusableView? in
      guard let self = self else { return nil }
      guard let sectionHeaderSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderSupplementaryView.reuseId, for: indexPath) as? SectionHeaderSupplementaryView else { return nil }
      sectionHeaderSupplementaryView.titleLabel.text = self.diffableDataSource.snapshot().sectionIdentifiers[indexPath.section].title
      return sectionHeaderSupplementaryView
    }
    
    var snapshot = NSDiffableDataSourceSnapshot<Section, Video>()
    let sections = self.tutorial.content
    snapshot.appendSections(sections)
    
    sections.forEach {
      snapshot.appendItems($0.videos, toSection: $0)
    }
  
    diffableDataSource.apply(snapshot)
    
  }
  
  func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
    let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50.0))
      let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      
      let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(75.0))
      let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
      section.boundarySupplementaryItems = [header]
      
      return section
    }
    
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
}
