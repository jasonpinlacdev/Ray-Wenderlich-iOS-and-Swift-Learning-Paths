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

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var tableView: TableView! {
        didSet { tableView.handleSelection = showItem }
    }
    
    @IBOutlet private var menuButton: UIButton!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet var menuViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var menuButtonTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet var titleCenterYConstraintClosed: NSLayoutConstraint!
    @IBOutlet var titleCenterYConstraintOpen: NSLayoutConstraint!
    
    private var slider: HorizontalItemSlider!
    private var menuIsOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider = HorizontalItemSlider(in: view) { [unowned self] item in
            self.tableView.addItem(item)
            self.transitionCloseMenu()
        }
        titleLabel.superview!.addSubview(slider)
    }
    
    @IBAction func toggleMenu() {
        menuIsOpen.toggle()
        
        titleLabel.text = menuIsOpen ? "Select Item!" : "Packing List"
        view.layoutIfNeeded()
        
        let constraints = titleLabel.superview!.constraints
        
        constraints.first { constraint in
            constraint.firstItem === titleLabel && constraint.firstAttribute == .centerX
        }?.constant = menuIsOpen ? -100 : 0
        
        titleCenterYConstraintOpen.isActive = menuIsOpen
        titleCenterYConstraintClosed.isActive = !menuIsOpen
        
        // MARK: Programmatic way of replacing a constraint for a new one that modfies the multiplier (get only)
//        constraints.first { constraint in
//            constraint.identifier == "Title Center Y"
//        }?.isActive = false
//
//        let newTitleLabelCenterYConstraint = NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: titleLabel.superview, attribute: .centerY, multiplier: menuIsOpen ? 2/3 : 1, constant: 0)
//        newTitleLabelCenterYConstraint.identifier = "Title Center Y"
//        newTitleLabelCenterYConstraint.priority = .defaultHigh
//        newTitleLabelCenterYConstraint.isActive  = true
        
        
        
        menuViewHeightConstraint.constant = menuIsOpen ? 200: 80
        menuButtonTrailingConstraint.constant = menuIsOpen ? 16 : 8
 
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: [.allowUserInteraction], animations: {
            self.menuButton.transform = CGAffineTransform(rotationAngle: self.menuIsOpen ? .pi/4 : 0)
            self.view.layoutIfNeeded()
        })
        
    }
    
    func showItem(_ item: Item) {
        let imageView = UIImageView(item: item)
        imageView.backgroundColor = .init(white: 0, alpha: 0.5)
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView(frame: imageView.frame)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        view.addSubview(containerView)
        
        let containerViewBottomAnchor = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: containerView.frame.height)
        let containerViewWidthAnchor = containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: -50)
        NSLayoutConstraint.activate([
            containerViewBottomAnchor,
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerViewWidthAnchor,
            containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
        ])
        
        view.layoutIfNeeded()
        
        containerViewBottomAnchor.constant = containerView.frame.height * -2
        containerViewWidthAnchor.constant = 0
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: [], animations: {
            self.view.layoutIfNeeded()
        })
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            UIView.transition(with: containerView, duration: 1, options: .transitionFlipFromBottom, animations: {
                imageView.removeFromSuperview()
            }, completion: { _ in
                containerView.removeFromSuperview()
            })
        })
        
    }
    
    func transitionCloseMenu() {
        
    
        let containerForSliderBar = slider.superview!
        
        UIView.transition(with: containerForSliderBar, duration: 0.5, options: .transitionFlipFromBottom, animations: {
            self.slider.isHidden = true
        }, completion: { _ in
            self.slider.isHidden = false
            self.toggleMenu()
        })
        
        
//        delay(seconds: 0.35, execute: toggleMenu)
    }
}

private func delay(seconds: TimeInterval, execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
}
