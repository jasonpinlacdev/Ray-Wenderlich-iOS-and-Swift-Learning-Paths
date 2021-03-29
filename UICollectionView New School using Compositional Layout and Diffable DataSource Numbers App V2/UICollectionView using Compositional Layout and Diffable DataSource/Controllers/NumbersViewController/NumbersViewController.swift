//
//  NumbersViewController.swift
//  UICollectionView using Compositional Layout and Diffable DataSource
//
//  Created by Jason Pinlac on 3/28/21.
//

import UIKit

class NumbersViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var diffableDataSource: NumbersDiffableDataSource!
    
    
    @IBOutlet var sortButtons: [UIBarButtonItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Numbers Collection"
        collectionView.collectionViewLayout = configureCollectionViewLayout()
        configureDiffableDataSource()
    }
    
    @IBAction func sortAscending(_ sender: UIBarButtonItem) {
        diffableDataSource.update(sortStyle: .ascending)
        updateSortButtonColors(sender: sender)
    }
    
    @IBAction func sortDescending(_ sender: UIBarButtonItem) {
        diffableDataSource.update(sortStyle: .descending)
        updateSortButtonColors(sender: sender)
    }
    
    @IBAction func sortRandom(_ sender: UIBarButtonItem) {
        diffableDataSource.update(sortStyle: .random)
        updateSortButtonColors(sender: sender)
    }
    
    func updateSortButtonColors(sender: UIBarButtonItem) {
        sortButtons.forEach {
            if $0 == sender {
                $0.tintColor = .systemRed
            } else {
                $0.tintColor = .systemGray
            }
        }
    }
    
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.1), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func configureDiffableDataSource() {
        diffableDataSource = NumbersDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let numberCell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.reuseId, for: indexPath) as? NumberCell else { fatalError() }
            numberCell.set(number: item)
            return numberCell
        })
        diffableDataSource.update(sortStyle: .ascending)
    }
    
}
