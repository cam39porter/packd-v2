//
//  EstablishmentFoldableCell.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/26/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class EstablishmentFoldableCell: FoldableCell {
    
    // START: Model
    var establishment: Establishment? = nil {
        didSet {
            nameLabel.text = establishment?.name
            descriptionLabel.text = establishment?.descriptionOfEstablishment
        }
    }
    
    var heart: Heart? = nil {
        didSet {
            if heart != nil {
                highlightHeartButton()
            } else {
                unHighlightHeartButton()
            }
        }
    }
    // END: Model
    
    // START: Fold Setup
    override func setupFolded() {
        super.setupFolded()
        addFoldedSubViews()
        anchorFoldedSubViews()
    }
    
    private func addFoldedSubViews() {
        addSubview(nameLabel)
        addSubview(descriptionLabel)
    }
    
    private func anchorFoldedSubViews() {
        anchorNameLabelFolded()
        anchorDescriptionLabelFolded()
    }
    
    override func setupHalfUnfolded() {
        super.setupHalfUnfolded()
    }
    
    private func addHalfUnfoldedSubViews() {
        
    }
    
    override func setupFullyUnfolded() {
        super.setupFullyUnfolded()
    }
    
    private func addFullyUnfoldedSubViews() {
    }
    // END: Fold Setup
    
    // START: View Components
    let detailsContianerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.contrast.withAlphaComponent(0.5)
        return view
    }()
    
    private func anchorDetailsContainerViewFullyUnfolded() {
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
    
    private func anchorProfileImageViewFullyUnfolded() {
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        profileImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: self.frame.height / 2).isActive = true
    }
    
    let heartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let icon = #imageLiteral(resourceName: "heart_icon")
        let tintIcon = icon.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(tintIcon, for: .normal)
        button.tintColor = Colors.contrast
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private func anchorHeartButtonFullyUnfolded() {
        heartButton.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: Size.minPadding).isActive = true
        heartButton.rightAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: -Size.minPadding).isActive = true
        heartButton.heightAnchor.constraint(equalToConstant: Size.oneFinger / 1.5).isActive = true
        heartButton.widthAnchor.constraint(equalToConstant: Size.oneFinger / 1.5).isActive = true
    }
    
    private func addTargetToHeartButton() {
        heartButton.addTarget(self, action: #selector(heartEstablishment), for: .touchUpInside)
    }
    
    private func highlightHeartButton() {
        heartButton.tintColor = Colors.highlight
    }
    
    private func unHighlightHeartButton() {
        heartButton.tintColor = Colors.contrast
    }
    
    @objc private func heartEstablishment() {
        if heartButton.tintColor == Colors.contrast {
            let newHeart = Heart.heart(establishmentWithUID: establishment?.uid!, byUserWithUID: User.getCurrentUserUID())
            self.heart = newHeart
        } else {
            Heart.remove(heart: heart!)
            heart = nil
        }
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
    
    private func anchorNameLabelFolded() {
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Size.minPadding).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Size.minPadding).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: self.bounds.width * 2/3).isActive = true
    }
    
    private func anchorNameLabelFullyUnfolded() {
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
    
    private func anchorDescriptionLabelFolded() {
        anchorDescriptionLabelFullyUnfolded()
    }
    
    private func anchorDescriptionLabelFullyUnfolded() {
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Size.minPadding).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Size.minPadding).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: self.bounds.width * 2/3).isActive = true
    }
    // END: View Components

}
