//
//  EstablishmentCell.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/14/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class EstablishmentCell: FoldableCell {
    // START: Model
    var establishment: Establishment? = nil {
        didSet {
            setupCell()
        }
    }
    
    var establishmentViewController: EstablishmentsViewController? = nil 
    // END: Model
    
    
    // START: View
    private func setupCell() {
        
        establishment?.getProfileImage(withCompletionHandler: { (image) in
            DispatchQueue.main.async {
                self.profileImageView.image = image
                self.establishmentViewController?.loadingStateOfCells[(self.indexPath?.item)!] = false
                self.establishmentViewController?.cellIsLoading = (self.establishmentViewController?.currentLoadState)!
                UIView.animate(withDuration: 1, animations: {
                    self.alpha = 1
                })
            }
        })
        
        nameLabel.text = establishment?.name
        descriptionLabel.text = establishment?.descriptionOfEstablishment
        
        addSubviews()
        
        anchorProfileImageView()
        anchorNameLabel()
        anchorDescriptionLabel()
        anchorDetailsContainerView()
    }
    
    private func addSubviews() {
        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(profileImageView)
        self.addSubview(detailsContianerView)
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
