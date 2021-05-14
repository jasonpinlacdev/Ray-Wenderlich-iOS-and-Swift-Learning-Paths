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

final class LibraryController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var dataSource: UICollectionViewDiffableDataSource<TutorialCollection, Tutorial>!
  let tutorialCollections = DataRepository.shared.tutorialCollections
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Ray Wenderlich Library"
    navigationController?.navigationBar.titleTextAttributes = [
      NSAttributedString.Key.font: UIFont(name: "American Typewriter", size: 24)!
  ]
    
    collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleSupplementaryView.reuseId)
    collectionView.collectionViewLayout = configureLayout()
    configureDataSource()
    collectionView.delegate = self
  }
  
  func configureLayout() -> UICollectionViewCompositionalLayout {
    let sectionProvider = { (sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.3))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuous
//      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//      section.interGroupSpacing = 10.0
      
      let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44.0))
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
      section.boundarySupplementaryItems = [sectionHeader]
      
      return section
    }
    
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, tutorial in
      guard let tutorialCell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialCell.reuseId, for: indexPath) as? TutorialCell else { fatalError() }
      tutorialCell.titleLabel.text = tutorial.title
      tutorialCell.thumbnailImageView.image = tutorial.image
      tutorialCell.thumbnailImageView.backgroundColor = tutorial.imageBackgroundColor
      return tutorialCell
    })
    
    dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
      guard let titleSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleSupplementaryView.reuseId, for: indexPath) as? TitleSupplementaryView else { return nil }
      titleSupplementaryView.titleLabel.text = self?.dataSource.snapshot().sectionIdentifiers[indexPath.section].title
      return titleSupplementaryView
    }
    
    var snapshot = NSDiffableDataSourceSnapshot<TutorialCollection, Tutorial>()
    snapshot.appendSections(tutorialCollections)
    tutorialCollections.forEach { tutorialCollection in
      snapshot.appendItems(tutorialCollection.tutorials, toSection: tutorialCollection)
    }
    dataSource.apply(snapshot, animatingDifferences: false)
  }
}

extension LibraryController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let tutorialDetailViewController = storyboard.instantiateViewController(identifier: "TutorialDetailViewController") { [weak self] coder -> TutorialDetailViewController? in
      guard let tutorial = self?.dataSource.itemIdentifier(for: indexPath) else { return nil }
      return TutorialDetailViewController(coder: coder, tutorial: tutorial)
    }
    self.navigationController?.pushViewController(tutorialDetailViewController, animated: true)
  }
}
