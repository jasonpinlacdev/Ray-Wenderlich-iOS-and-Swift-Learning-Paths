//
//  NumbersDiffableDataSource.swift
//  UICollectionView using Compositional Layout and Diffable DataSource
//
//  Created by Jason Pinlac on 3/28/21.
//

import UIKit

enum SortStyle {
    case ascending
    case descending
    case random
}

class NumbersDiffableDataSource: UICollectionViewDiffableDataSource<Data.Section, Int> {
    
    func update(sortStyle: SortStyle) {
       
        var snapshot = NSDiffableDataSourceSnapshot<Data.Section, Int>()
        
        switch sortStyle {
        case .ascending:
            let allSections = Data.Section.allCases
            snapshot.appendSections(allSections)
            allSections.forEach {
                if let numbersInSection = Data.shared.numbers[$0] {
                    snapshot.appendItems(numbersInSection, toSection: $0)
                }
            }
        case .descending:
            var allSections = Data.Section.allCases
            allSections.reverse()
            snapshot.appendSections(allSections)
            allSections.forEach {
                if var numbersInSection = Data.shared.numbers[$0] {
                    numbersInSection.reverse()
                    snapshot.appendItems(numbersInSection, toSection: $0)
                }
            }
        case .random:
            var allSections = Data.Section.allCases
            allSections.shuffle()
            snapshot.appendSections(allSections)
            allSections.forEach {
                if var numbersInSection = Data.shared.numbers[$0] {
                    numbersInSection.shuffle()
                    snapshot.appendItems(numbersInSection, toSection: $0)
                }
            }
        }
        
        self.apply(snapshot)
    }
    
    
}
