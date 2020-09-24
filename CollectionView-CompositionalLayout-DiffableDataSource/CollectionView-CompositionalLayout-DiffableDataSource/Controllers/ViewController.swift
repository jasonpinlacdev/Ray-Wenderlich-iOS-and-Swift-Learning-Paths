//
//  ViewController.swift
//  CollectionView-CompositionalLayout-DiffableDataSource
//
//  Created by Jason Pinlac on 9/23/20.
//

import UIKit

enum Section: String, CaseIterable {
    case main
}

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var diffableDatasource: UICollectionViewDiffableDataSource<Section, Int>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = configureCollectionViewLayout()
        configureDiffableDatasource()
    }

    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func configureDiffableDatasource() {
        diffableDatasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, number) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCollectionViewCell.reuseId, for: indexPath) as? NumberCollectionViewCell else {
                fatalError("Failed to dequeue NumberCollectionViewCell")
            }
            cell.label.text = number.description
            cell.contentView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1.0)
            return cell
        })
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        initialSnapshot.appendSections(Section.allCases)
        initialSnapshot.appendItems(Array(Range(1...100)), toSection: .main)
        diffableDatasource.apply(initialSnapshot, animatingDifferences: false)
    }

}

