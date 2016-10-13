//
//  NavigationButtons.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/12/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class NavigationButtons: NSObject {
    
    func setupNavigationButtons(inView view: UIView) {
        
        view.addSubview(packdButton)
        
        packdButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        packdButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        packdButton.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        packdButton.widthAnchor.constraint(equalToConstant: Size.oneFinger * 2).isActive = true
        
    }
    
    let packdButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        button.setTitle("PACKD", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNextCondensed-UltraLight", size: 24)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let profileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        return button
    }()
    

}
