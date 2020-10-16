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
    
    enum Section {
        case main
    }
    
    static let badgeElementKind: String = "badge-element-kind"
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()
    
    @IBOutlet var deleteButton: UIBarButtonItem!
    @IBOutlet var updateButton: UIBarButtonItem!
    @IBOutlet var applyUpdatesButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var diffableDataSource: UICollectionViewDiffableDataSource<Section, Tutorial>!
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { [weak self] _ in
            self?.triggerUpdates()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
                self?.applyUpdates()
            }
        })
    }
    
    private func setupView() {
        self.title = "Queue"
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = nil
        
        collectionView.collectionViewLayout = configureCollectionViewLayout()
        configureDataSource()
        
        collectionView.register(BadgeSupplementaryView.self, forSupplementaryViewOfKind: QueuedTutorialController.badgeElementKind, withReuseIdentifier: BadgeSupplementaryView.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSnapshot()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.isEditing = false
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
        let tutorials = selectedIndexPaths.compactMap { diffableDataSource.itemIdentifier(for: $0) }
        
        tutorials.forEach { $0.isQueued = false }
        
        var currentSnapshot = diffableDataSource.snapshot()
        currentSnapshot.deleteItems(tutorials)
        diffableDataSource.apply(currentSnapshot, animatingDifferences: true)
        
        isEditing.toggle()
    }
    
    @IBAction func triggerUpdates() {
        let indexPaths = collectionView.indexPathsForVisibleItems
        let randomIndex = indexPaths[Int.random(in: 0 ..< indexPaths.count)]
        let tutorial = diffableDataSource.itemIdentifier(for: randomIndex)
        tutorial?.updateCount = 3
        let badgeView = collectionView.supplementaryView(forElementKind: QueuedTutorialController.badgeElementKind, at: randomIndex)
        badgeView?.isHidden = false
    }
    
    @IBAction func applyUpdates() {
        let tutorials = diffableDataSource.snapshot().itemIdentifiers
        if var firstTutorial = tutorials.first,
           tutorials.count > 1 {
            
            let tutorialsWithUpdates = tutorials.filter { $0.updateCount > 0 }
            var currentSnapshot = diffableDataSource.snapshot()
            
            tutorialsWithUpdates.forEach { tutorial in
                if tutorial != firstTutorial {
                    currentSnapshot.moveItem(tutorial, beforeItem: firstTutorial)
                    firstTutorial = tutorial
                    tutorial.updateCount = 0
                }
            }
            
            if let firstIndexPath = diffableDataSource.indexPath(for: firstTutorial) {
                let badgeView = collectionView.supplementaryView(forElementKind: QueuedTutorialController.badgeElementKind, at: firstIndexPath) as? BadgeSupplementaryView
                badgeView?.isHidden = true
            }
            
            diffableDataSource.apply(currentSnapshot, animatingDifferences: true)
        }
    }
}

// MARK: - Collection View Compositional Layout -

extension QueuedTutorialController {
    
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let anchorEdges: NSDirectionalRectEdge = [.top, .trailing]
        let offset = CGPoint(x: 3.0, y: -3.0)
        let badgeAnchor = NSCollectionLayoutAnchor(edges: anchorEdges, absoluteOffset: offset)
        let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20.0), heightDimension: .absolute(20.0))
        let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: QueuedTutorialController.badgeElementKind, containerAnchor: badgeAnchor)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [badge])
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(148))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: - Diffable Data Source -

extension QueuedTutorialController {
    
    func configureDataSource() {
        // MARK: - Dequeue Cell -
        diffableDataSource = UICollectionViewDiffableDataSource<Section, Tutorial>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, tutorial: Tutorial) in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QueueCell.reuseIdentifier, for: indexPath) as? QueueCell else {
                return nil
            }
            
            cell.titleLabel.text = tutorial.title
            cell.thumbnailImageView.image = tutorial.image
            cell.thumbnailImageView.backgroundColor = tutorial.imageBackgroundColor
            cell.publishDateLabel.text = tutorial.formattedDate(using: self.dateFormatter)
            
            return cell
        }
        
        // MARK: - Dequeue Badge -
        diffableDataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) -> UICollectionReusableView? in
            if let badgeSupplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: QueuedTutorialController.badgeElementKind, withReuseIdentifier: BadgeSupplementaryView.reuseIdentifier, for: indexPath) as? BadgeSupplementaryView {
                guard let tutorial = self?.diffableDataSource.itemIdentifier(for: indexPath) else { return nil }
                badgeSupplementaryView.isHidden = tutorial.updateCount > 0 ? false : true
                return badgeSupplementaryView
            } else {
                return nil
            }
        }
    }
    
    func configureSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Tutorial>()
        snapshot.appendSections([.main])
        
        let queuedTutorials = DataSource.shared.tutorials.flatMap { $0.queuedTutorials }
        snapshot.appendItems(queuedTutorials)
        
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
}
