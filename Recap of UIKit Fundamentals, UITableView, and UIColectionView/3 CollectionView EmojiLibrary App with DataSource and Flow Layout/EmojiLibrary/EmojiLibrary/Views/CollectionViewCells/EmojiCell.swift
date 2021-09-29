/// These materials have been reviewed and are updated as of September, 2020
///
/// Copyright (c) 2020 Razeware LLC
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
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
///

import UIKit

class EmojiCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: EmojiCell.self)
  
  // This var is needed to check if the viewController the collectionView and its cells are on is in edit mode or not.
  weak var sourceViewController: UIViewController?
    
  @IBOutlet weak var emojiLabel: UILabel!
  
  // collectionView keeps track of which indexPaths have been "selected" in its array collectionView.indexPathsOfSelectedItems.
  // so, anytime we dequeue a reusable cell, we can to check if it is for an indexPath that is considered "selected".
  // if so, we want to change the background color to red. if not "selected" then we make sure it dequeues with a background color gray.
  // Also, we do all this logic ONLY if we are in edit mode.
  
  override var isSelected: Bool {
    // the isSelected property gets assigned everytime this cell gets dequeued. The value assigned is based off the collectionView's indexPathForSelectedItems array.
    didSet {
      guard let sourceViewController = sourceViewController else { return }
      self.contentView.backgroundColor = (isSelected && sourceViewController.isEditing) ? .systemRed : .none
    }
  }
}
