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
  
  static let storyboardIdentifer = String(describing: TutorialDetailViewController.self)
  
  let tutorial: Tutorial
  
  @IBOutlet weak var tutorialCoverImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var publishDateLabel: UILabel!
  @IBOutlet weak var queueButton: UIButton!
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var tutorialDetailCollectionViewDiffableDataSource: TutorialDetailCollectionViewDiffableDataSource!
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init?(coder: NSCoder, tutorial: Tutorial) {
    self.tutorial = tutorial
    super.init(coder: coder)
  }
  
  lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d"
    return formatter
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    collectionView.register(TutorialDetailSectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TutorialDetailSectionHeaderCollectionReusableView.reuseIdentifier)
    collectionView.collectionViewLayout = configureCollectionViewCompositionalLayout()
    configureCollectionViewDiffableDataSource()
  }
  
  private func setupView() {
    self.title = tutorial.title
    tutorialCoverImageView.image = tutorial.image
    tutorialCoverImageView.backgroundColor = tutorial.imageBackgroundColor
    titleLabel.text = tutorial.title
    publishDateLabel.text = tutorial.formattedDate(using: dateFormatter)
    
    let buttonTitle = tutorial.isQueued ? "Remove from queue" : "Add to queue"
    queueButton.setTitle(buttonTitle, for: .normal)
  }
  
  
  private func configureCollectionViewDiffableDataSource() {
    tutorialDetailCollectionViewDiffableDataSource = TutorialDetailCollectionViewDiffableDataSource(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, video) -> UICollectionViewCell? in
      guard let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCell.reuseIdentifier, for: indexPath) as? ContentCell else { fatalError("Failed to dequeue a reusable cell.")}
      contentCell.textLabel.text = self.tutorialDetailCollectionViewDiffableDataSource.itemIdentifier(for: indexPath)?.title
      return contentCell
    })
    tutorialDetailCollectionViewDiffableDataSource.sourceViewController = self
    tutorialDetailCollectionViewDiffableDataSource.applyInitialSnapshot()
    
    tutorialDetailCollectionViewDiffableDataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
      guard let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TutorialDetailSectionHeaderCollectionReusableView.reuseIdentifier, for: indexPath) as? TutorialDetailSectionHeaderCollectionReusableView else { return nil }
      sectionHeaderView.sectionTitleLabel.text = self.tutorialDetailCollectionViewDiffableDataSource.sectionIdentifier(for: indexPath.section)?.title
      return sectionHeaderView
    }
  }
  
  
  private func configureCollectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
    let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
//      item.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.1))
      let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
//      section.interGroupSpacing = 10.0
    
      let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.1))
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
      section.boundarySupplementaryItems = [sectionHeader]
      
      return section
    }
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
  
  @IBAction func toggleQueued() {
    self.tutorial.isQueued.toggle()
    print(tutorial.isQueued)
    UIView.performWithoutAnimation {
      if tutorial.isQueued {
        queueButton.setTitle("Remove from queue", for: .normal)
      } else {
        queueButton.setTitle("Add to queue", for: .normal)
      }
      
      self.queueButton.layoutIfNeeded()
    }
  }
}
