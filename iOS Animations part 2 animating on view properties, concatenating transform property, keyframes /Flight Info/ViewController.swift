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
    @IBOutlet var background: UIImageView!
    
    @IBOutlet var summaryIcon: UIImageView!
    @IBOutlet var summary: UILabel!
    
    @IBOutlet var flightNumberLabel: UILabel!
    @IBOutlet var gateNumberLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    @IBOutlet var destinationLabel: UILabel!
    @IBOutlet var plane: UIImageView!
    
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var statusBanner: UIImageView!
    
    private let snowView = SnowView( frame: .init(x: -150, y:-100, width: 300, height: 50) )
}

//MARK:- UIViewController
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the snow effect layer
        let snowClipView = UIView( frame: view.frame.offsetBy(dx: 0, dy: 50) )
        snowClipView.clipsToBounds = true
        snowClipView.addSubview(snowView)
        view.addSubview(snowClipView)
        
        // Start rotating the flights
        changeFlight(to: .londonToParis, animated: false)
    }
}

private extension ViewController {
    //MARK:- Animations
    
    func fade(to image: UIImage, showEffects: Bool) {
        let tempImageView = UIImageView(frame: view.frame)
        tempImageView.image = image
        // These are the view's animatable properties. Assigned starting state values
        tempImageView.alpha = 0
        tempImageView.center.y += 20
        tempImageView.bounds.width
        background.superview?.insertSubview(tempImageView, aboveSubview: background)
        
        UIView.animate(withDuration: 0.5, animations: {
            // These are the view's animatable properties. Assigned ending state values
            tempImageView.alpha = 1.0
            tempImageView.center.y -= 20
            tempImageView.bounds.size = self.background.bounds.size
        }, completion: { _ in
            self.background.image = tempImageView.image
            tempImageView.removeFromSuperview()
        })
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.snowView.alpha = showEffects ? 1.0 : 0.0
        }, completion: nil)
    }
    
    func move(label: UILabel, text: String, offset: CGPoint) {
        // create an invisible label below real label and configure it
        let tempLabel = UILabel(frame: label.frame)
        tempLabel.font = label.font
        tempLabel.textAlignment = label.textAlignment
        tempLabel.textColor = label.textColor
        tempLabel.backgroundColor = label.backgroundColor
        
        tempLabel.text = text
        tempLabel.alpha = 0
        tempLabel.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        background.insertSubview(tempLabel, aboveSubview: label)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            // fade out real label and move it down
            label.alpha = 0
            label.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.25, options: .curveEaseIn, animations: {
            // fade in temp label and move it up
            tempLabel.alpha = 1.0
            tempLabel.transform = .identity
        }, completion: { _ in
            // update the real labels value, show it and reset it to its original position
            label.text = text
            label.transform = .identity
            label.alpha = 1.0
            // remove the temp label
            tempLabel.removeFromSuperview()
        })
        
    }
    
    func cubeTransition(label: UILabel, text: String) {
        // 3 steps. starting value, animating to the end value, clean up
        
        let scale: CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 0.0001)
        let translate: CGAffineTransform = CGAffineTransform(translationX: 0.0, y: label.frame.height/2)
        
        // setup temp label with new text directly on top of the real label that is scaled down
        let tempLabel = duplicate(label)
        tempLabel.text = text
        tempLabel.shadowColor = label.shadowColor
        tempLabel.shadowOffset = label.shadowOffset
        tempLabel.transform = scale.concatenating(translate)
        
        label.superview!.addSubview(tempLabel)
        
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
            // animate temp label and original label to move up simultaneously while temp label scales up and original label scales down
            tempLabel.transform = .identity
            label.transform = scale.concatenating(translate.inverted())
        }, completion: { _ in
            // change original text to temp labels value. reset orginal label to original position. remove temp label
            label.text = text
            label.transform = .identity
            tempLabel.removeFromSuperview()
        })
        
    }
    
    func depart() {
        //TODO: Animate the plane taking off and landing
    }
    
    func changeSummary(to summaryText: String) {
        //TODO: Animate the summary text
    }
    
    func changeFlight(to flight: Flight, animated: Bool = false) {
        // populate the UI with the next flight's data
        flightNumberLabel.text = flight.number
        gateNumberLabel.text = flight.gateNumber
        summary.text = flight.summary
        
        if animated {
            // TODO: Call your animation
            fade(to: UIImage(named:  flight.weatherImageName)!, showEffects: flight.showWeatherEffects)
            move(label: originLabel, text: flight.origin, offset: CGPoint(x: -50.0, y: 0.0))
            move(label: destinationLabel, text: flight.destination, offset: flight.showWeatherEffects ? CGPoint(x: 0.0, y: 50.0) : CGPoint(x: 0.0, y: -50.0))
            cubeTransition(label: statusLabel, text: flight.status)
        } else {
            background.image = UIImage(named: flight.weatherImageName)
            originLabel.text = flight.origin
            destinationLabel.text = flight.destination
            statusLabel.text = flight.status
        }
        
        // schedule next flight
        delay(seconds: 3) {
            self.changeFlight(to: flight.isTakingOff ? .parisToRome : .londonToParis, animated: true)
        }
    }
    
    //MARK:- utility methods
    func duplicate(_ label: UILabel) -> UILabel {
        let newLabel = UILabel(frame: label.frame)
        newLabel.font = label.font
        newLabel.textAlignment = label.textAlignment
        newLabel.textColor = label.textColor
        newLabel.backgroundColor = label.backgroundColor
        return newLabel
    }
}

private func delay(seconds: TimeInterval, execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
}
