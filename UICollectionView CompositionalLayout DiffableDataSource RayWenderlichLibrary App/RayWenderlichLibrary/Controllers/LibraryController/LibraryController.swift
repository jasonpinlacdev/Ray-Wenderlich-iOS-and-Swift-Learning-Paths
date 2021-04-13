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
  
  var diffableDataSource: LibraryDiffableDataSource!
  lazy var delegate = LibraryDelegate(controller: self)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Library"
    collectionView.register(SectionHeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderSupplementaryView.reuseId)
    collectionView.collectionViewLayout = configureCompositionalLayout()
    configureDiffableDataSource()
    collectionView.delegate = delegate
  }
  
}

// MARK: - CollectionView Cofiguration -
extension LibraryController {
  func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
    let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let pad: CGFloat = 10.0
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: pad, leading: pad, bottom: pad, trailing: pad)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.3))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
      
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .groupPaging
      section.contentInsets = NSDirectionalEdgeInsets(top: -pad * 2, leading: 0, bottom: pad * 2, trailing: 0)
      section.interGroupSpacing = pad
      
      let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(75.0))
      let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
      section.boundarySupplementaryItems = [header]
      
      return section
    }
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
  
  func configureDiffableDataSource() {
    diffableDataSource = LibraryDiffableDataSource(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, tutorial) -> UICollectionViewCell? in
      guard let tutorialCell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialCell.reuseIdentifier, for: indexPath) as? TutorialCell else { fatalError("Failed to dequeue reusable TutorialCell.") }
      tutorialCell.titleLabel.text = tutorial.title
      tutorialCell.thumbnailImageView.image = tutorial.image
      return tutorialCell
    })
    
    diffableDataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) -> UICollectionReusableView? in
      guard let self = self else { return nil }
      guard let librarySectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderSupplementaryView.reuseId, for: indexPath) as? SectionHeaderSupplementaryView else { return nil }
      librarySectionHeaderView.titleLabel.text = self.diffableDataSource.snapshot().sectionIdentifiers[indexPath.section].title
      return librarySectionHeaderView
    }
    diffableDataSource.update(animatingDifferences: false)
  }
}
