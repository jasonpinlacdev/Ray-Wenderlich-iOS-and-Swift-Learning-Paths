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


class numberDiffableDataSource: UICollectionViewDiffableDataSource<NumbersSection, Int> {

  func updateWithInitialSnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<NumbersSection, Int>()
    snapshot.appendSections(NumbersSection.allCases)
    NumbersSection.allCases.forEach { section in
      guard let numbersAtSection = DataRepository.shared.numbersData[section] else { return }
      snapshot.appendItems(numbersAtSection, toSection: section)
    }
    self.apply(snapshot)
  }
  
  func updateWithSnapshot(using sortStyle: NumbersSortStyle) {
    
  }
  
}
