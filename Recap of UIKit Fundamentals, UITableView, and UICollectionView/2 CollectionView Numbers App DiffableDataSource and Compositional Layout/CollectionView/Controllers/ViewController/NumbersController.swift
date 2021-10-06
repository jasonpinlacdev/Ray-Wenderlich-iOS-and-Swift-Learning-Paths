//
//  ViewController.swift
//  CollectionView
//
//  Created by Jason Pinlac on 9/15/21.
//

import UIKit

class NumbersController: UIViewController {

  @IBOutlet var collectionView: UICollectionView!
  
  lazy var diffableDataSource: NumbersDiffableDataSource = NumbersDiffableDataSource(collectionView: self.collectionView) { collectionView, indexPath, number in
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCollectionViewCell.reuseId, for: indexPath) as? NumberCollectionViewCell else { fatalError("Failed to dequeue a reusable NumberCollectionViewCell.")}
    cell.textLabel.text = number.description
    cell.contentView.backgroundColor = UIColor(red: CGFloat.random(in: 0.1...1), green: CGFloat.random(in: 0.1...1), blue: CGFloat.random(in: 0.1...1), alpha: 1.0)
    return cell
  }
  
  let compositionalLayout: UICollectionViewCompositionalLayout = {
    let numberItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.10), heightDimension: .fractionalWidth(0.10))
    let numberItem = NSCollectionLayoutItem(layoutSize: numberItemSize)
    numberItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2.5, bottom: 0, trailing: 2.5)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.10))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [numberItem])
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 2.5, leading: 0, bottom: 2.5, trailing: 0)
    let compositionalLayout = UICollectionViewCompositionalLayout(section: section)
    return compositionalLayout
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(NumberCollectionViewCell.self, forCellWithReuseIdentifier: NumberCollectionViewCell.reuseId)
    collectionView.collectionViewLayout = compositionalLayout
    diffableDataSource.update(as: .random, animatingDifferences: false)
  }

}

