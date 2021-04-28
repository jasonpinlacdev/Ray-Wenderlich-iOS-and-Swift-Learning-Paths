//
//  ColorsDiffableDataSource.swift
//  UICollectionView CompositionalLayout SectionHeaderFooterSupplementaryViews
//
//  Created by Jason Pinlac on 3/31/21.
//

import UIKit

class ColorsDiffableDataSource: UICollectionViewDiffableDataSource<Data.ColorsSection, Color> {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let colorsSectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ColorsSectionHeaderView.reuseId, for: indexPath) as? ColorsSectionHeaderView else { fatalError()}
        colorsSectionHeaderView.setSection(text: Data.ColorsSection.allCases[indexPath.section].rawValue)
        return colorsSectionHeaderView
    }
}
