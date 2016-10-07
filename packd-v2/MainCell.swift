//
//  MainCell.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/6/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

struct MainCellConstants {
    static let reuseIdentifier: String = "mainCell"
    
    static let establishmentImage = UIImage(named: "establishments_bg")
    static let friendsImage = UIImage(named: "friends_bg")
    static let perksImage = UIImage(named: "perks_bg")
    
    static let backgroundImageDictionary: [Int:UIImage] = [0 : MainCellConstants.establishmentImage!,
                                                           1 : MainCellConstants.friendsImage!,
                                                           2 : MainCellConstants.perksImage!]
    
    static let establishmentIndex = 0
    static let friendsIndex = 1
    static let perksIndex = 2
}

class MainCell: UICollectionViewCell {
    
    // START: View
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        addSubview(imageView)


    }
    
    let imageView: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width / 4), y: (UIScreen.main.bounds.height / 3), width: 200, height: 200))
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .white
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 100
        iv.layer.masksToBounds = true
        return iv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // END: view
    
}
