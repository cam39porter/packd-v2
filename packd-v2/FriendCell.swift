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
                self.profileImageView.image = #imageLiteral(resourceName: "friends_bg")
                self.smallProfileImageView.image = image
                self.friendsViewController?.loadingStateOfCellsByUID[(self.friend?.uid)!] = false
                self.friendsViewController?.cellIsLoading = (self.friendsViewController?.currentLoadState)!
                UIView.animate(withDuration: 1, animations: {
                    self.alpha = 1
                })
            }
        })

        nameLabel.text = friend?.name
        descriptionLabel.text = friend?.email
        
        addSubviews()
        anchorSubviews()
        
    }
    
    private func addSubviews() {
        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(profileImageView)
        self.addSubview(detailsContianerView)
        self.addSubview(smallProfileImageView)
    }
    
    private func anchorSubviews() {
        anchorProfileImageView()
        anchorNameLabel()
        anchorDescriptionLabel()
        anchorDetailsContainerView()
        anchorSmallProfileImageView()
    }
    
    let detailsContianerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.contrast.withAlphaComponent(0.5)
        return view
    }()
    
    private func anchorDetailsContainerView() {
        detailsContianerView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 0).isActive = true
        detailsContianerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        detailsContianerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        detailsContianerView.widthAnchor.constraint(equalToConstant: self.bounds.width * 1/3).isActive = true
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private func anchorProfileImageView() {
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        profileImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: self.frame.height / 2).isActive = true
    }
    
    let smallProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Size.oneFinger
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = Colors.highlight.cgColor
        return imageView
    }()
    
    private func anchorSmallProfileImageView() {
        smallProfileImageView.heightAnchor.constraint(equalToConstant: Size.oneFinger * 2).isActive = true
        smallProfileImageView.widthAnchor.constraint(equalToConstant: Size.oneFinger * 2).isActive = true
        smallProfileImageView.centerXAnchor.constraint(equalTo: detailsContianerView.leftAnchor, constant: 0).isActive = true
        smallProfileImageView.centerYAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 0).isActive = true
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textColor = Colors.contrast
        label.textAlignment = .left
        label.font = Fonts.boldFont(ofSize: 18)
        return label
    }()
    
    private func anchorNameLabel() {
        nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: Size.minPadding).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Size.minPadding).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: self.bounds.width * 2/3).isActive = true
    }
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textColor = Colors.contrast
        label.textAlignment = .left
        label.font = Fonts.font(ofSize: 14)
        return label
    }()
    
    private func anchorDescriptionLabel() {
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Size.minPadding).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Size.minPadding).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: self.bounds.width * 2/3).isActive = true
    }
    // END: View
}
