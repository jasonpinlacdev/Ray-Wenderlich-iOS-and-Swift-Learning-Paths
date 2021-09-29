//
//  ViewControllerDiffableDataSource.swift
//  CollectionView
//
//  Created by Jason Pinlac on 9/15/21.
//

import UIKit

enum NumbersSection: String, CaseIterable {
  case ones = "Ones"
  case tens = "Tens"
  case twenties = "Twenties"
  case thirties = "Thirties"
  case forties = "Forties"
  case fifties = "Fifties"
  case sixties = "Sixties"
  case seventies = "Seventies"
  case eighties = "Eighties"
  case nineties = "Nineties"
}

enum NumbersSortStyle {
  case random
  case ascending
  case descending
}


class NumbersDiffableDataSource: UICollectionViewDiffableDataSource<NumbersSection, Int> {
  
  var currentSortStyle: NumbersSortStyle = .ascending
  
  func update(as sortStyle: NumbersSortStyle, animatingDifferences: Bool = false) {
    self.currentSortStyle = sortStyle
    var snapshot = NSDiffableDataSourceSnapshot<NumbersSection, Int>()
    switch currentSortStyle {
    case .ascending:
      snapshot.appendSections(NumbersSection.allCases)
      NumbersSection.allCases.forEach { section in
        if let numbersAtSection = DataRepository.shared.numbersData[section] {
          snapshot.appendItems(numbersAtSection, toSection: section)
        }
      }
    case .descending:
      snapshot.appendSections(NumbersSection.allCases.reversed())
      NumbersSection.allCases.forEach { section in
        if let numbersAtSection = DataRepository.shared.numbersData[section]?.reversed() {
          let numbersAtSectionReversed = numbersAtSection.reversed()
          snapshot.appendItems(numbersAtSectionReversed, toSection: section)
        }
      }
    case .random:
      let sectionsRandomized = NumbersSection.allCases.shuffled()
      snapshot.appendSections(sectionsRandomized)
      sectionsRandomized.forEach { section in
        if let numbersInSectionRandomized = DataRepository.shared.numbersData[section]?.shuffled() {
          snapshot.appendItems(numbersInSectionRandomized, toSection: section)
        }
      }
    }
    self.apply(snapshot, animatingDifferences: animatingDifferences)
  }
  
}
