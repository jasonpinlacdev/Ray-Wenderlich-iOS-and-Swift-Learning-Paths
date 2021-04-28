//
//  ColorsViewController.swift
//  UICollectionView FlowLayout SectionHeaderFooterSupplementaryViews
//
//  Created by Jason Pinlac on 3/30/21.
//

import UIKit

class ColorsViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    let dataSource = ColorsDataSource()
    let delegateFlowLayout = ColorsDelegateFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UICollectionView + FlowLayout + DataSource"
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.register(ColorsSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ColorsSectionHeaderView.reuseId)
        collectionView.dataSource = dataSource
        collectionView.delegate = delegateFlowLayout
    }
    
    
}
