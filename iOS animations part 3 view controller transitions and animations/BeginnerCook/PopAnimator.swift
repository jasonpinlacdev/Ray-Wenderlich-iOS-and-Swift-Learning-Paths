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

final class PopAnimator: NSObject {
    
    
    var isPresenting = true
    var originFrame = CGRect()
    private let duration: TimeInterval = 1.0

}

extension PopAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        // this is how long the transition animation lasts
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 1) set up transition (start value)
        let containerView = transitionContext.containerView
        
        guard let herbView = transitionContext.view(forKey: isPresenting ? .to : .from) else { return }
        
        let initialFrameToView: CGRect = isPresenting ? originFrame : herbView.frame
        let finalFrameToView: CGRect = isPresenting ? herbView.frame : originFrame
        
        let scaleTransform = isPresenting ? CGAffineTransform(scaleX: initialFrameToView.width/finalFrameToView.width, y: initialFrameToView.height/finalFrameToView.height) : CGAffineTransform(scaleX: finalFrameToView.width/initialFrameToView.width, y: finalFrameToView.height/initialFrameToView.height)
        
        if isPresenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(x: initialFrameToView.midX, y: initialFrameToView.midY)
        }
        
        herbView.layer.cornerRadius = isPresenting ? 20 / scaleTransform.a : 0
        herbView.clipsToBounds = true
      
        if let toView = transitionContext.view(forKey: .to) {
            containerView.addSubview(herbView)
        }
        
        containerView.bringSubviewToFront(herbView)
        
        guard let herbDetailsContainerView = ( transitionContext.viewController(forKey: isPresenting ? .to : .from) as? HerbDetailsViewController )?.containerView else { return }
        
        herbDetailsContainerView.alpha = isPresenting ? 0 : 1
        
        // 2) animate (to end value)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, animations: {
            herbView.transform =  self.isPresenting ? .identity : scaleTransform
            herbView.center = CGPoint(x: finalFrameToView.midX, y: finalFrameToView.midY)
            herbDetailsContainerView.alpha  = self.isPresenting ? 1 : 0
            herbView.layer.cornerRadius = self.isPresenting ? 0 : 20 / scaleTransform.a
            
        }, completion: { _ in
            // 3) complete the transition (clean up)
            if !self.isPresenting {
                (transitionContext.viewController(forKey: .to) as? ViewController)?.selectedImage.alpha = 1.0
            }
            transitionContext.completeTransition(true)
        })
    }
}
