import UIKit

final class GenreCollectionController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  
  var genreCollectionDiffableDataSource: GenreCollectionDiffableDataSource!
  lazy var genreCollectionViewDelegate = GenreCollectionDelegate(sourceViewController: self)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Library"
    collectionView.register(GenreSectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GenreSectionHeaderCollectionReusableView.reuseIdentifier)
    collectionView.collectionViewLayout = configureCompositionalLayout()
    configureDiffableDataSource()
    collectionView.delegate = genreCollectionViewDelegate
  }
  
}



extension GenreCollectionController {
  
  private func configureDiffableDataSource() {
    self.genreCollectionDiffableDataSource = GenreCollectionDiffableDataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, tutorial in
      guard let tutorialCell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialCell.reuseIdentifier, for: indexPath) as? TutorialCell else { fatalError("Failed to dequeue a TutorialCell") }
      tutorialCell.thumbnailImageView.backgroundColor = tutorial.imageBackgroundColor
      tutorialCell.thumbnailImageView.image = tutorial.image
      tutorialCell.titleLabel.text = tutorial.title
      return tutorialCell
    })
    
    genreCollectionDiffableDataSource.applyInitialSnapshot()
    
    genreCollectionDiffableDataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) -> UICollectionReusableView? in
      guard let genreSectionTitleCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GenreSectionHeaderCollectionReusableView.reuseIdentifier, for: indexPath) as? GenreSectionHeaderCollectionReusableView else { fatalError("Failed to dequeue GenreSectionTitleCollectionReusableView") }
      genreSectionTitleCollectionReusableView.sectionTitleLabel.text = self?.genreCollectionDiffableDataSource.snapshot().sectionIdentifiers[indexPath.section].title
      return genreSectionTitleCollectionReusableView
    }
    
  }
  
  
  private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
    let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      // section provider allows us to define different section layouts based off index
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.3))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuous
      section.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
      section.interGroupSpacing = 10.0
      
      let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.1))
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
      section.boundarySupplementaryItems = [sectionHeader]
      
      return section
    }
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
  
}
