//
//  AboutViewController.swift
//  Bullseye-UIKit
//
//  Created by Jason Pinlac on 6/12/20.
//  Copyright © 2020 Jason Pinlac. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About Bullseye"
        setupBackground()
        configureUIElementsAndLayout()
    }
    
    
    private func setupBackground() {
        let backgroundImageView = UIImageView(image: UIImage(named: "Background"))
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    
    private func configureUIElementsAndLayout() {
        let beigeContainer = UIView()
        beigeContainer.backgroundColor = UIColor(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0, alpha: 1.0)
        beigeContainer.translatesAutoresizingMaskIntoConstraints = false
        beigeContainer.layer.borderColor = UIColor.black.cgColor
        beigeContainer.layer.borderWidth = 2
        beigeContainer.layer.cornerRadius = 10
        beigeContainer.clipsToBounds = true
        beigeContainer.setShadow()
        
        view.addSubview(beigeContainer)
        
        NSLayoutConstraint.activate([
            beigeContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            beigeContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            beigeContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            beigeContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
        
        let aboutTitle = "🎯 Bullseye 🎯"
        let aboutBody = """
                           This is Bullseye, the game where you can win points and earn fame by dragging a slider.
                           Your goal is to place the slider as close as possible to the target value.
                           The closer you are, the more points you score.
                           Enjoy!
                           """
        
        let aboutTitleLabel = UILabel()
        aboutTitleLabel.font = UIFont.systemFont(ofSize: 26)
        aboutTitleLabel.text = aboutTitle
        aboutTitleLabel.textColor = UIColor.black
        aboutTitleLabel.textAlignment = .center
        aboutTitleLabel.numberOfLines = 0
        aboutTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let aboutBodyLabel = UILabel()
        aboutBodyLabel.font = UIFont.systemFont(ofSize: 26)
        aboutBodyLabel.text = aboutBody
        aboutBodyLabel.textColor = UIColor.black
        aboutBodyLabel.textAlignment = .center
        aboutBodyLabel.numberOfLines = 4
        aboutBodyLabel.adjustsFontSizeToFitWidth = true
        aboutBodyLabel.minimumScaleFactor = 0.25
        aboutBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        beigeContainer.addSubview(aboutTitleLabel)
        beigeContainer.addSubview(aboutBodyLabel)
        
        NSLayoutConstraint.activate([
            aboutTitleLabel.topAnchor.constraint(equalTo: beigeContainer.topAnchor, constant: 25),
            aboutTitleLabel.centerXAnchor.constraint(equalTo: beigeContainer.centerXAnchor),
            
            aboutBodyLabel.topAnchor.constraint(equalTo: aboutTitleLabel.bottomAnchor, constant: -10),
            aboutBodyLabel.centerXAnchor.constraint(equalTo: beigeContainer.centerXAnchor),
            aboutBodyLabel.leadingAnchor.constraint(equalTo: beigeContainer.leadingAnchor, constant: 20),
            aboutBodyLabel.trailingAnchor.constraint(equalTo: beigeContainer.trailingAnchor, constant: -20),
        ])
    }
    
    
}
