//
//  PhotosViewController.swift
//  UICollectionViewCompositionalLayout Demo
//
//  Created by Jason Pinlac on 3/29/21.
//

import UIKit

class ColorsViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    let dataSource = ColorsDataSource()
    let delegate = ColorsDelegate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Traditional DataSource + Compositional Layout"
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
//        collectionView.collectionViewLayout = configureCompositionalLayout()
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }
    
    func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let inset: CGFloat = 2.5
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0) , heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    
}
