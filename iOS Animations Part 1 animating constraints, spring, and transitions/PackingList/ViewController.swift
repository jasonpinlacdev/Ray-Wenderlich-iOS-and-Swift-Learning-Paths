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

final class ViewController: UIViewController {
    
    @IBOutlet private var tableView: TableView! {
        didSet { tableView.handleSelection = showItem }
    }
    
    @IBOutlet private var menuButton: UIButton!
    @IBOutlet private var titleLabel: UILabel!
    
    // this is a reference to the height constraint that belongs the the menu view
    @IBOutlet private var menuHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var menuButtonTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet var titleLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var titleLabelCenterYOpenConstraint: NSLayoutConstraint!
    @IBOutlet var titleLabelCenterYClosedConstraint: NSLayoutConstraint!
    
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
        
        titleLabel.text = menuIsOpen ? "Select Item" : "Packing List"
        view.layoutIfNeeded()
        
        // MARK: - getting the titleLable's centerX constraint -
//        let parentViewConstraints = titleLabel.superview!.constraints
//        if let titleLabelCenterXConstraint = parentViewConstraints.first(where: { $0.firstItem === titleLabel && $0.firstAttribute == .centerX }) {
//            titleLabelCenterXConstraint.constant = self.menuIsOpen ? -100 : 0
//            UIView.animate(withDuration: 0.8, animations: {
//                self.view.layoutIfNeeded()
//            })
//        }

        // MARK: - getting the titleLable's centerY constraint -
//        let superViewConstraints = titleLabel.superview!.constraints
//        superViewConstraints.first { $0.identifier == "Title Center Y" }?.isActive = false
//
//        let constraint = NSLayoutConstraint(item: titleLabel!, attribute: .centerY, relatedBy: .equal, toItem: titleLabel.superview, attribute: .centerY, multiplier: menuIsOpen ? 2 / 3 : 1, constant: 0)
//        constraint.identifier = "Title Center Y"
//        constraint.priority = .defaultHigh
//        constraint.isActive = true
        
        titleLabelCenterXConstraint.constant = menuIsOpen ? -100 : 0
        
        titleLabelCenterYOpenConstraint.isActive = menuIsOpen ? true : false
        titleLabelCenterYClosedConstraint.isActive = menuIsOpen ? false : true

        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 7, options: .allowUserInteraction, animations: {
            self.menuHeightConstraint.constant = self.menuIsOpen ? 200 : 80
            self.menuButtonTrailingConstraint.constant = self.menuIsOpen ? 16 : 8
            self.menuButton.transform = self.menuIsOpen ? CGAffineTransform(rotationAngle: CGFloat.pi/4) : CGAffineTransform(rotationAngle: 0)
            self.view.layoutIfNeeded()
        }, completion: nil)
        
//        UIView.animate(withDuration: 1/3, delay: 0, options: .curveEaseIn, animations: {
//            self.menuHeightConstraint.constant = self.menuIsOpen ? 200 : 80
//            self.menuButtonTrailingConstraint.constant = self.menuIsOpen ? 16 : 8
//            self.menuButton.transform = self.menuIsOpen ? CGAffineTransform(rotationAngle: CGFloat.pi/4) : CGAffineTransform(rotationAngle: 0)
//            self.view.layoutIfNeeded()
//        })
        
    }
    
    func showItem(_ item: Item) {
       
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        let imageView = UIImageView(item: item)
        imageView.backgroundColor = .init(white: 0, alpha: 0.5)
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        
        let bottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: imageView.bounds.height)
        let widthConstraint = containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: -50)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor),
        
            bottomConstraint,
            widthConstraint,
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor),
        ])
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 7, options: [], animations: {
            bottomConstraint.constant = imageView.bounds.height * -2
            widthConstraint.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        delay(seconds: 1.25, execute: {
            UIView.transition(with: containerView, duration: 2/3, options: .transitionFlipFromBottom, animations: {
                imageView.removeFromSuperview()
                self.view.layoutIfNeeded()
            }, completion: { _ in
                containerView.removeFromSuperview()
            })
        })
        
//        UIView.animate(withDuration: 2/3, delay: 1.25, animations: {
//            imageViewBottomConstraint.constant = imageView.bounds.height
//            imageViewWidthConstraint.constant = -50
//            self.view.layoutIfNeeded()
//        }, completion: { _ in
//            imageView.removeFromSuperview()
//        })
    
    }
    
    func transitionCloseMenu() {
        delay(seconds: 0.35, execute: {
            self.toggleMenu()
        })
    }
    
    func delay(seconds: TimeInterval, execute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
    }
}

