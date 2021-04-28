//
//  ColorsController.swift
//  UICollectionView CompositionalLayout SectionHeaderFooterSupplementaryViews
//
//  Created by Jason Pinlac on 3/31/21.
//

import UIKit

class ColorsController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var diffableDataSource: ColorsDiffableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UICollectionView + CompositionalLayout + DiffDataSource"
        collectionView.collectionViewLayout = configureCompositionalLayout()
        collectionView.register(ColorsSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ColorsSectionHeaderView.reuseId)
        configureDiffableDataSource()
    }
    
    func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemsPerRow: CGFloat = 3.0
        let spacing: CGFloat = 2.5
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/itemsPerRow), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0/itemsPerRow))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [header]
        
        return UICollectionViewCompositionalLayout(section: section)
    }

    func configureDiffableDataSource() {
        diffableDataSource = ColorsDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, color) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.reuseId, for: indexPath) as? ColorCell else { fatalError() }
            cell.set(color)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Data.ColorsSection, Color>()
        let allSections = Data.ColorsSection.allCases
        snapshot.appendSections(allSections)
        
        Data.ColorsSection.allCases.forEach {
            let colorsInSection = Data.shared.colors[$0]!
            snapshot.appendItems(colorsInSection, toSection: $0)
        }
        diffableDataSource.apply(snapshot)
    }
    
}
