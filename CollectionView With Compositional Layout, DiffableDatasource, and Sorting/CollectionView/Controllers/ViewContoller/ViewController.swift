//
//  ViewController.swift
//  CollectionView
//
//  Created by Jason Pinlac on 3/1/21.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var sortButtons: [UIBarButtonItem]!
    
    var diffableDataSource: ViewControllerDiffableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Numbers in a Collection View"
        collectionView.collectionViewLayout = configureLayout()
        configureDatasource()
    }
    
    func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.20), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.20))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func configureDatasource() {
        self.diffableDataSource = ViewControllerDiffableDataSource(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, number) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.reuseId, for: indexPath) as? NumberCell else { fatalError() }
            cell.set(text: number.description)
            return cell
        })
        diffableDataSource.updateDatasource(sortStyle: .random)
    }
    
    
    @IBAction func sortByAscendingOrder(_ sender: UIBarButtonItem) {
        diffableDataSource.updateDatasource(sortStyle: .ascending)
        changeSortButtonColors(sender: sender)
    }
    
    @IBAction func sortByDescendingOrder(_ sender: UIBarButtonItem) {
        diffableDataSource.updateDatasource(sortStyle: .descending)
        changeSortButtonColors(sender: sender)
    }
    
    @IBAction func sortByRandomOrder(_ sender: UIBarButtonItem) {
        diffableDataSource.updateDatasource(sortStyle: .random)
        changeSortButtonColors(sender: sender)
    }
    
    func changeSortButtonColors(sender: UIBarButtonItem) {
        sortButtons.forEach {
            $0.tintColor = ($0 == sender) ? .systemPurple : .secondaryLabel
        }
    }
}
