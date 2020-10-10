/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class QueuedTutorialController: UIViewController {
    
    enum QueuedSection {
        case main
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()
    
    @IBOutlet var deleteButton: UIBarButtonItem!
    @IBOutlet var updateButton: UIBarButtonItem!
    @IBOutlet var applyUpdatesButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var diffableDataSource: UICollectionViewDiffableDataSource<QueuedSection, Tutorial>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshDiffableDataSource()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.isEditing = false
    }
    
    private func setupView() {
        self.title = "Queue"
        navigationItem.leftBarButtonItem =  editButtonItem
        navigationItem.rightBarButtonItem = nil
        configureDiffableDataSource()
        collectionView.collectionViewLayout = configureCollectionViewCompositionalLayout()
    }
}

// MARK: - Queue Events -

extension QueuedTutorialController {
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if isEditing {
            navigationItem.rightBarButtonItems = nil
            navigationItem.rightBarButtonItem = deleteButton
        } else {
            navigationItem.rightBarButtonItem = nil
            navigationItem.rightBarButtonItems = [self.applyUpdatesButton, self.updateButton]
        }
        
        collectionView.allowsMultipleSelection = true
        collectionView.indexPathsForVisibleItems.forEach { indexPath in
            guard let cell = collectionView.cellForItem(at: indexPath) as? QueueCell else { return }
            cell.isEditing = isEditing
            
            if !isEditing {
                cell.isSelected = false
            }
        }
    }
    
    @IBAction func deleteSelectedItems() {
        guard let selectedIndexPaths = collectionView.indexPathsForSelectedItems else { return }
        let tutorials = selectedIndexPaths.compactMap { indexPath in
           return diffableDataSource.itemIdentifier(for: indexPath)
        }
        
        tutorials.forEach { $0.isQueued = false}
        
        var currentSnapshot = diffableDataSource.snapshot()
        currentSnapshot.deleteItems(tutorials)
        diffableDataSource.apply(currentSnapshot, animatingDifferences: true)
        
        isEditing = false
    }
    
    @IBAction func triggerUpdates() {
        
    }
    
    @IBAction func applyUpdates() {

    }
}


// MARK: - CompositionalLayout and DiffableDataSource Configurations -

extension QueuedTutorialController {
    private func configureCollectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemsSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(148))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureDiffableDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource<QueuedSection, Tutorial>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, tutorial) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QueueCell.reuseIdentifier, for: indexPath) as? QueueCell else { fatalError("Failed to dequeue reusable ContentCell") }
            cell.titleLabel.text = tutorial.title
            cell.thumbnailImageView.image = tutorial.image
            cell.thumbnailImageView.backgroundColor = tutorial.imageBackgroundColor
            cell.publishDateLabel.text = tutorial.formattedDate(using: self.dateFormatter)
            return cell
        })
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<QueuedSection, Tutorial>()
        initialSnapshot.appendSections([QueuedSection.main])
        
        let queuedTutorials = DataSource.shared.tutorials.flatMap { tutorialCollection in
            tutorialCollection.queuedTutorials
        }
        
        initialSnapshot.appendItems(queuedTutorials, toSection: QueuedSection.main)
        diffableDataSource.apply(initialSnapshot, animatingDifferences: true)
    }
    
//    func refreshDiffableDataSource() {
//        var initialSnapshot = NSDiffableDataSourceSnapshot<QueuedSection, Tutorial>()
//        initialSnapshot.appendSections([QueuedSection.main])
//
//        let queuedTutorials = DataSource.shared.tutorials.flatMap { tutorialCollection in
//            tutorialCollection.queuedTutorials
//        }
//
//        initialSnapshot.appendItems(queuedTutorials, toSection: QueuedSection.main)
//        diffableDataSource.apply(initialSnapshot, animatingDifferences: false)
//    }
    
}
