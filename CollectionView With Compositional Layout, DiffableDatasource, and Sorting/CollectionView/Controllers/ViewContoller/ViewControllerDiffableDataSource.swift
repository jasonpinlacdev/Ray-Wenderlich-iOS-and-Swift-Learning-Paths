//
//  ViewControllerDiffableDataSource.swift
//  CollectionView
//
//  Created by Jason Pinlac on 3/2/21.
//

import UIKit

enum Section: CaseIterable {
    case main
}

enum SortStyle {
    case ascending
    case descending
    case random
}

class ViewControllerDiffableDataSource: UICollectionViewDiffableDataSource<Section, Int> {
    
    func updateDatasource(sortStyle: SortStyle) {
    
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections(Section.allCases)
        
        let sortedNumbers: [Int]
        switch sortStyle {
        case .ascending:
            sortedNumbers = Data.shared.numbers.sorted { $0 < $1 }
        case .descending:
            sortedNumbers = Data.shared.numbers.sorted { $0 > $1 }
        case .random:
            sortedNumbers = Data.shared.numbers
        }
    
        snapshot.appendItems(sortedNumbers, toSection: .main)
        apply(snapshot, animatingDifferences: true)
    }
    
}
