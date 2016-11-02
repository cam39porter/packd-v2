//
//  FriendFoldableCell.swift
//  packd-v2
//
//  Created by Cameron Porter on 11/2/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class FriendFoldableCell: FoldableCell {
    
    // START: Model
    static let identifier = "friendCell"
    
    var friend: User? = nil {
        didSet {
            nameLabel.text = friend?.name
            descriptionLabel.text = friend?.email
            friend?.getProfileImage(withCompletionHandler: { (image) in
                self.profileImageView.image = image
            })
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
        
        self.layer.shadowRadius = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        
//        setupHeartButton()
        
        alphaProfileImageViewFolded()
        
        removeFoldedSubviews()
        addFoldedSubViews()
        anchorFoldedSubViews()
        addTargets()
        
    }
    
    private func removeFoldedSubviews() {
        lessButton.removeFromSuperview()
    }
    
    private func addFoldedSubViews() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(heartButton)
        addSubview(moreButton)
    }
    
    private func anchorFoldedSubViews() {
        anchorProfileImageViewFolded()
        anchorNameLabelFolded()
        anchorDescriptionLabelFolded()
        anchorHeartButtonFolded()
        anchorMoreButtonFolded()
    }
    
    private func addTargets() {
//        addTargetToHeartButton()
        addTargetMoreButton()
    }
    
    override func setupHalfUnfolded() {
        super.setupHalfUnfolded()
        
        addHalfUnfoldedSubviews()
        anchorHalfUnfoldedSubviews()
        
        addTargetlessButton()
    }
    
    private func addHalfUnfoldedSubviews() {
        addSubview(lessButton)
    }
    
    private func anchorHalfUnfoldedSubviews() {
        anchorlessButtonHalfUnfolded()
    }
    
    override func setupFullyUnfolded() {
        super.setupFullyUnfolded()
        
        removeSubviewsForFullyUnfolded()
        addFullyUnfoldedSubViews()
        anchorFullyUnfoldedSubviews()
        
        alphaProfileImageViewFullyUnfolded()
        
    }
    
    private func removeSubviewsForFullyUnfolded() {
        profileImageView.removeFromSuperview()
        nameLabel.removeFromSuperview()
        descriptionLabel.removeFromSuperview()
        moreButton.removeFromSuperview()
    }
    
    private func addFullyUnfoldedSubViews() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(detailsContianerView)    }
    
    private func anchorFullyUnfoldedSubviews() {
        anchorProfileImageViewFullyUnfolded()
        anchorNameLabelFullyUnfolded()
        anchorDescriptionLabelFullyUnfolded()
        anchorDetailsContainerViewFullyUnfolded()
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
    
    private func alphaProfileImageViewFolded() {
        profileImageView.alpha = 0.10
    }
    
    private func alphaProfileImageViewFullyUnfolded() {
        profileImageView.alpha = 1
    }
    
    private func anchorProfileImageViewFolded() {
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        profileImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func anchorProfileImageViewHalfUnfolded() {
        anchorProfileImageViewFolded()
    }
    
    private func anchorProfileImageViewFullyUnfolded() {
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        profileImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: self.frame.height / 2).isActive = true
        sendSubview(toBack: profileImageView)
    }
    
    let heartButton: SpringButton = {
        let button = SpringButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let icon = #imageLiteral(resourceName: "heart_icon")
        let tintIcon = icon.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(tintIcon, for: .normal)
        button.tintColor = Colors.contrast
        button.contentMode = .scaleAspectFit
        return button
    }()
    
//    private func setupHeartButton() {
//        User.isHearted(byUserWithUID: User.getCurrentUserUID()!, forEstablishmentUID: establishment?.uid!, withCompletionHandler: { (heart) in
//            self.heart = heart
//        })
//    }
    
    private func anchorHeartButtonFolded() {
        heartButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Size.minPadding).isActive = true
        heartButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Size.minPadding).isActive = true
        heartButton.heightAnchor.constraint(equalToConstant: Size.oneFinger / 2).isActive = true
        heartButton.widthAnchor.constraint(equalToConstant: Size.oneFinger / 2).isActive = true
    }
    
    private func anchorHeartButtonFullyUnfolded() {
        heartButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Size.minPadding).isActive = true
        heartButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Size.minPadding).isActive = true
        heartButton.heightAnchor.constraint(equalToConstant: Size.oneFinger / 1.5).isActive = true
        heartButton.widthAnchor.constraint(equalToConstant: Size.oneFinger / 1.5).isActive = true
    }
    
//    private func addTargetToHeartButton() {
//        heartButton.addTarget(self, action: #selector(heartEstablishment), for: .touchUpInside)
//    }
    
    private func highlightHeartButton() {
        heartButton.tintColor = Colors.highlight
    }
    
    private func unHighlightHeartButton() {
        heartButton.tintColor = Colors.contrast
    }
    
    private func animateHeartButton() {
        heartButton.animation = Spring.AnimationPreset.Pop.rawValue
        heartButton.curve = Spring.AnimationCurve.EaseInOutCubic.rawValue
        heartButton.animate()
    }
    
//    @objc private func heartEstablishment() {
//        if heartButton.tintColor == Colors.contrast {
//            animateHeartButton()
//            let newHeart = Heart.heart(establishmentWithUID: establishment?.uid!, byUserWithUID: User.getCurrentUserUID())
//            self.heart = newHeart
//        } else {
//            Heart.remove(heart: heart!)
//            heart = nil
//        }
//    }
    
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
    
    let moreButton: SpringButton = {
        let button = SpringButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let icon = #imageLiteral(resourceName: "more_icon")
        let tintIcon = icon.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(tintIcon, for: .normal)
        button.tintColor = Colors.contrast
        return button
    }()
    
    private func anchorMoreButtonFolded() {
        moreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Size.minPadding).isActive = true
        moreButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Size.minPadding).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: Size.oneFinger / 2).isActive = true
        moreButton.widthAnchor.constraint(equalToConstant: Size.oneFinger / 2).isActive = true
    }
    
    private func addTargetMoreButton() {
        moreButton.addTarget(self, action: #selector(unfold), for: .touchUpInside)
    }
    
    let lessButton: SpringButton = {
        let button = SpringButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let icon = #imageLiteral(resourceName: "less_icon")
        let tintIcon = icon.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(tintIcon, for: .normal)
        button.tintColor = Colors.contrast
        return button
    }()
    
    private func anchorlessButtonHalfUnfolded() {
        lessButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Size.minPadding).isActive = true
        lessButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Size.minPadding).isActive = true
        lessButton.heightAnchor.constraint(equalToConstant: Size.oneFinger / 2).isActive = true
        lessButton.widthAnchor.constraint(equalToConstant: Size.oneFinger / 2).isActive = true
    }
    
    private func addTargetlessButton() {
        lessButton.addTarget(self, action: #selector(fold), for: .touchUpInside)
    }
    // END: View Components
}
