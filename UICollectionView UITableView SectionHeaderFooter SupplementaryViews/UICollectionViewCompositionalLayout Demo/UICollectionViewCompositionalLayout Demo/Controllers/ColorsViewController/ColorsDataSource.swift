//
//  PhotosDataSource.swift
//  UICollectionViewCompositionalLayout Demo
//
//  Created by Jason Pinlac on 3/29/21.
//

import UIKit

enum Section: String, CaseIterable {
    case main
}

class ColorsDataSource: NSObject {
    
}

extension ColorsDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        DataLayer.shared.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.reuseId, for: indexPath) as? ColorCell else { fatalError() }
        let photo = DataLayer.shared.colors[indexPath.item]
        photoCell.set(color: photo)
        return photoCell
    }
}
