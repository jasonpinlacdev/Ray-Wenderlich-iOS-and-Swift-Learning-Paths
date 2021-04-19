//
//  FlickrDiffableDataSource.swift
//  FlickrImages URLSession App
//
//  Created by Jason Pinlac on 4/18/21.
//

import UIKit

enum Section: CaseIterable {
  case main
}

class FlickrDiffableDataSource: UITableViewDiffableDataSource<Section, FlickrPhoto> {
  func update(with flickrPhotos: [FlickrPhoto]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, FlickrPhoto>()
    let allSections = Section.allCases
    snapshot.appendSections(allSections)
    allSections.forEach {
      snapshot.appendItems(flickrPhotos, toSection: $0)
    }
    self.apply(snapshot)
  }
}
