//
//  EmojiSectionCollectionReusableView.swift
//  EmojiLibrary
//
//  Created by Jason Pinlac on 9/29/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

class EmojiSectionHeaderCollectionReusableView: UICollectionReusableView {
   
    static let reuseIdentifier = String(describing: EmojiSectionHeaderCollectionReusableView.self)
    
    @IBOutlet var sectionLabel: UILabel!
    
}

