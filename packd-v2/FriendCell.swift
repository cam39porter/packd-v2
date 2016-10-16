//
//  FriendCell.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/14/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class FriendCell: FoldableCell {

    // START: Model
    var friend: User? = nil {
        didSet {
            setupCell()
        }
    }
    
    var friendsViewController: FriendsViewController? = nil
    // END: Model
    
    // START: View
    private func setupCell() {
        
        friend?.getProfileImage(withCompletionHandler: { (image) in
            DispatchQueue.main.async {
                self.profileImageView.image = image
                print(self.indexPath?.item)
                self.friendsViewController?.loadingStateOfCells[(self.indexPath?.item)!] = false
                self.friendsViewController?.cellIsLoading = (self.friendsViewController?.currentLoadState)!
                UIView.animate(withDuration: 1, animations: {
                    self.alpha = 1
                })
            }
        })

        nameLabel.text = friend?.name
        descriptionLabel.text = friend?.email
        
        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(profileImageView)
        
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        profileImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: self.frame.height / 2).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: Size.minPadding).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Size.minPadding).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: Size.minPadding).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Size.minPadding).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Size.minPadding).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: Size.minPadding).isActive = true
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = Fonts.boldFont(ofSize: 18)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = Fonts.font(ofSize: 14)
        return label
    }()
    // END: View
}
