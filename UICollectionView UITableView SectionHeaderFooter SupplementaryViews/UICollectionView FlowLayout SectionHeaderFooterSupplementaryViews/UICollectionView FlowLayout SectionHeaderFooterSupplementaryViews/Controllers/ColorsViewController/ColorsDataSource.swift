//
//  ColorsDataSource.swift
//  UICollectionView FlowLayout SectionHeaderFooterSupplementaryViews
//
//  Created by Jason Pinlac on 3/30/21.
//

import UIKit

class ColorsDataSource: NSObject {
    
}

extension ColorsDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Data.ColorsSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Data.shared.colors[Data.ColorsSection.allCases[section]]!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let colorCell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.reuseId, for: indexPath) as? ColorCell else { fatalError() }
        let section = Data.ColorsSection.allCases[indexPath.section]
        let color = Data.shared.colors[section]![indexPath.item]
        colorCell.set(color: color)
        return colorCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let colorsSectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ColorsSectionHeaderView.reuseId, for: indexPath) as? ColorsSectionHeaderView else { fatalError() }
        colorsSectionHeaderView.label.text = Data.ColorsSection.allCases[indexPath.section].rawValue
        return colorsSectionHeaderView
    }
    
}
