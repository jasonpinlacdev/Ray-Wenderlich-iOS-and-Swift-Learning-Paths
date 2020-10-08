/// Copyright (c) 2019 Razeware LLC
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
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.


import UIKit

final class LibraryController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var diffableDataSource: UICollectionViewDiffableDataSource<TutorialCollection, Tutorial>!
    let tutorials = DataSource.shared.tutorials
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        collectionView.collectionViewLayout = configureCollectionViewCompositionalLayout()
        configureDiffableDataSource()
    }
    
    private func setupView() {
        self.title = "Library"
    }
    
    func configureCollectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        // this section provider closure is used to customize the section behavior base
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.interGroupSpacing = 10
            
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    func configureDiffableDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, tutorial) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialCell.reuseIdentifier, for: indexPath) as? TutorialCell else { fatalError("Failed to dequeue reusable TutorialCell.") }
            cell.titleLabel.text = tutorial.title
            cell.thumbnailImageView.image = tutorial.image
            cell.thumbnailImageView.backgroundColor = tutorial.imageBackgroundColor
            return cell
        })
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<TutorialCollection, Tutorial>()
        
        tutorials.forEach { tutorialCollection in
            initialSnapshot.appendSections([tutorialCollection])
//            initialSnapshot.appendItems(tutorialCollection.tutorials, toSection: tutorialCollection)
        }
        
        tutorials.forEach { tutorialCollection in
//            initialSnapshot.appendSections([tutorialCollection])
            initialSnapshot.appendItems(tutorialCollection.tutorials, toSection: tutorialCollection)
        }
        diffableDataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
         
    
    
}
