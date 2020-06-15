//
//  BullseyeViewController.swift
//  Bullseye-UIKit
//
//  Created by Jason Pinlac on 6/12/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class BullseyeViewController: UIViewController {
    
    let targetDescriptionLabel = BEDescriptionLabel(text: "Put the bullseye as close as you can to:")
    let targetNumberLabel = BEValueLabel(value: "100")
    
    let slider = BESlider()
    
    let minSliderLabel = BEValueLabel(value: "1", fontSize: 18.0, textColor: .white)
    let maxSliderLabel = BEValueLabel(value: "100", fontSize: 18.0, textColor: .white)
    
    let hitMeButton = BEButton(title: "Hit Me!", target: self, action: #selector(hitMeButtonTapped(_:)), forEvent: .touchUpInside)
    let startOverButton = BESmallButton(type: .startOver ,target: self, action: #selector(startOverButtonTapped(_:)), forEvent: .touchUpInside)
    let infoButton: BESmallButton = BESmallButton(type: .Information ,target: self, action: #selector(infoButtonTapped(_:)), forEvent: .touchUpInside)
    
    let scoreDescriptionLabel = BEDescriptionLabel(text: "Score:")
    let scoreNumberLabel = BEValueLabel(value: "999999")
    
    let roundDescriptionLabel = BEDescriptionLabel(text: "Round:")
    let roundNumberLabel = BEValueLabel(value: "999")
    
    
    var target = 0 {
        didSet {
            targetNumberLabel.text = "\(target)"
        }
    }
    
    var score = 0 {
        didSet {
            scoreNumberLabel.text = "\(score)"
        }
    }
    
    var round = 0 {
        didSet {
            roundNumberLabel.text = "\(round)"
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bullseye"
        setupBackground()
        layoutUIElements()
        startOver()
    }
    
    
    @objc func hitMeButtonTapped(_ sender: UIButton) {
        let sliderValue = Int(slider.value.rounded())
        let points = 100 - (abs(sliderValue - target))
        var bonusPoints = 0
        let alertTitle: String
        let alertMessage: String
        
        switch points {
        case 100:
            bonusPoints = 100
            alertTitle = "Bullseye!"
            alertMessage = "You scored a perfect bullseye baby! 200 points!"
            
        case 99:
            bonusPoints = 50
            alertTitle = "So Close!"
            alertMessage = "You scored \(points) points and \(bonusPoints) bonus points."
            
        case 90...98:
            alertTitle = "Almost"
            alertMessage = "You scored \(points) points."
        default:
            alertTitle = "Not Even Close"
            alertMessage = "You scored \(points) points."
        }
        
        let totalPoints = points + bonusPoints
        
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default) { action in
            self.newRound()
            self.score += totalPoints
        })
        present(alert, animated: true)
        
    }
    
    
    func newRound() {
        round += 1
        target = Int.random(in: 1...100)
        slider.value = 50.0
    }
    
    @objc func startOverButtonTapped(_ sender: UIButton) {
        startOver()
    }
    
    func startOver() {
        score = 0
        round = 0
        target = Int.random(in: 1...100)
        slider.value = 50.0
    }
    
    @objc func infoButtonTapped(_ sender: UIButton) {
        let aboutViewController = AboutViewController()
        navigationController?.pushViewController(aboutViewController, animated: true)
    }
    
    
    
    private func setupBackground() {
        let backgroundImageView = UIImageView(image: UIImage(named: "Background"))
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -50),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    
    private func layoutUIElements() {
        view.addSubview(targetDescriptionLabel)
        view.addSubview(targetNumberLabel)
        view.addSubview(slider)
        view.addSubview(minSliderLabel)
        view.addSubview(maxSliderLabel)
        view.addSubview(hitMeButton)
        
        view.addSubview(startOverButton)
        view.addSubview(infoButton)
        view.addSubview(scoreDescriptionLabel)
        view.addSubview(scoreNumberLabel)
        view.addSubview(roundDescriptionLabel)
        view.addSubview(roundNumberLabel)
        
        NSLayoutConstraint.activate([
            targetDescriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            targetDescriptionLabel.widthAnchor.constraint(equalToConstant: 425),
            targetDescriptionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -50),
            
            targetNumberLabel.centerYAnchor.constraint(equalTo: targetDescriptionLabel.centerYAnchor),
            targetNumberLabel.leadingAnchor.constraint(equalTo: targetDescriptionLabel.trailingAnchor, constant: 5),
            
            
            
            slider.topAnchor.constraint(equalTo: targetDescriptionLabel.bottomAnchor, constant: 15),
            slider.heightAnchor.constraint(equalToConstant: 100),
            slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
            
            
            minSliderLabel.widthAnchor.constraint(equalToConstant: 50),
            minSliderLabel.trailingAnchor.constraint(equalTo: slider.leadingAnchor),
            minSliderLabel.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
            
            
            maxSliderLabel.widthAnchor.constraint(equalToConstant: 50),
            maxSliderLabel.leadingAnchor.constraint(equalTo: slider.trailingAnchor, constant: 10),
            maxSliderLabel.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
            
            
            
            hitMeButton.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 15),
            hitMeButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -25),
            hitMeButton.widthAnchor.constraint(equalToConstant: 100),
            hitMeButton.heightAnchor.constraint(equalToConstant: 40),
            
            startOverButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            startOverButton.centerXAnchor.constraint(equalTo: minSliderLabel.centerXAnchor, constant: 10),
            startOverButton.widthAnchor.constraint(equalToConstant: 40),
            startOverButton.heightAnchor.constraint(equalToConstant: 40),
            
            infoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            infoButton.centerXAnchor.constraint(equalTo: maxSliderLabel.centerXAnchor, constant: -10),
            infoButton.widthAnchor.constraint(equalToConstant: 40),
            infoButton.heightAnchor.constraint(equalToConstant: 40),
            

            
            scoreDescriptionLabel.centerYAnchor.constraint(equalTo: startOverButton.centerYAnchor),
            scoreDescriptionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -25 - 150),
            
            scoreNumberLabel.centerYAnchor.constraint(equalTo: startOverButton.centerYAnchor),
            scoreNumberLabel.leadingAnchor.constraint(equalTo: scoreDescriptionLabel.trailingAnchor, constant: 10),
            
            roundDescriptionLabel.centerYAnchor.constraint(equalTo: startOverButton.centerYAnchor),
            roundDescriptionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -25 + 100),
            
            roundNumberLabel.centerYAnchor.constraint(equalTo: startOverButton.centerYAnchor),
            roundNumberLabel.leadingAnchor.constraint(equalTo: roundDescriptionLabel.trailingAnchor, constant: 10),
            
            
            
        ])
        
    }
    
}
