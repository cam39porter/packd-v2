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
        view.addSubview(searchButton)
        view.addSubview(profileButton)
        view.addSubview(messageButton)
        
        packdButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        packdButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        packdButton.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        packdButton.widthAnchor.constraint(equalToConstant: Size.oneFinger * 2).isActive = true
        
        searchButton.centerYAnchor.constraint(equalTo: packdButton.centerYAnchor, constant: 0).isActive = true
        searchButton.leftAnchor.constraint(equalTo: packdButton.rightAnchor, constant: 0).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: Size.oneFinger / 2).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: Size.oneFinger / 2).isActive = true
        
        profileButton.centerYAnchor.constraint(equalTo: packdButton.centerYAnchor, constant: 0).isActive = true
        profileButton.rightAnchor.constraint(equalTo: messageButton.leftAnchor, constant: -Size.minPadding).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: Size.oneFinger / 2).isActive = true
        profileButton.widthAnchor.constraint(equalToConstant: Size.oneFinger / 2).isActive = true
        
        messageButton.centerYAnchor.constraint(equalTo: packdButton.centerYAnchor, constant: 0).isActive = true
        messageButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Size.minPadding).isActive = true
        messageButton.heightAnchor.constraint(equalToConstant: Size.oneFinger / 2).isActive = true
        messageButton.widthAnchor.constraint(equalToConstant: Size.oneFinger / 2).isActive = true
    }
    
    let packdButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        button.setTitle("PACKD", for: .normal)
        button.titleLabel?.font =  Fonts.boldFont(ofSize: Size.oneFinger / 2)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let searchButton: UIButton = {
        return NavigationButtons.createNavButton(withIcon: UIImage(named: "search_nav_icon"))
    }()
    
    let profileButton: UIButton = {
        return NavigationButtons.createNavButton(withIcon: UIImage(named: "profile_nav_icon"))
    }()
    
    let messageButton: UIButton = {
        return NavigationButtons.createNavButton(withIcon: UIImage(named: "message_nav_icon"))
    }()
    
    static func createNavButton(withIcon icon: UIImage?) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        let tintIcon = icon?.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(tintIcon, for: .normal)
        button.tintColor = UIColor.black
        button.contentMode = .scaleAspectFit
        return button
    }

}
