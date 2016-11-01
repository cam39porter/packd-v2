//
//  EstablishmentCell.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/14/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit
import AudioToolbox

class EstablishmentCell: FoldableCell {
    // START: Model
    var establishment: Establishment? = nil {
        didSet {
            setupCell()
        }
    }
    
    var heart: Heart? = nil {
        didSet {
            establishmentViewController?.hearts[(self.indexPath?.item)!] = heart

            if heart != nil {
               highlightHeartButton()
            } else {
                unHighlightHeartButton()
            }
        }
    }
    
    var establishmentViewController: EstablishmentsViewController? = nil 
    // END: Model
    
    
    // START: View
    private func setupCell() {
        
        establishment?.getProfileImage(withCompletionHandler: { (image) in
            DispatchQueue.main.async {
                self.profileImageView.image = image
                self.establishmentViewController?.loadingStateOfCellsByUID[(self.establishment?.uid)!] = false
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
        anchorHeartButton()
        
        addTargetToHeartButton()
    }
    
    private func addSubviews() {
        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(profileImageView)
        self.addSubview(detailsContianerView)
        self.addSubview(heartButton)
    }
    
    let detailsContianerView: UIView = {
        let view = SpringView()
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
    
    private func anchorHeartButton() {
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
    
    private func animateHeartButton() {
        heartButton.animation = Spring.AnimationPreset.Pop.rawValue
        heartButton.curve = Spring.AnimationCurve.EaseInOutCubic.rawValue
        heartButton.animate()
    }
    
    @objc private func heartEstablishment() {
        if heartButton.tintColor == Colors.contrast {
            animateHeartButton()
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
    
    // START: Touches
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if is3DTouchAvailble() && establishmentViewController?.isAddingCellToStack == false {
                if touch.force == touch.maximumPossibleForce {
                    establishmentViewController?.isAddingCellToStack = true
                    AudioServicesPlaySystemSound(1520)
                    addCellToStack()
                }
            }
        }
    }
    
    private func is3DTouchAvailble() -> Bool {
        if #available(iOS 9.0, *) {
            if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                return true
            }
        }
        return false
    }
    // END: Touches
    
    // START: Stack
    private func addCellToStack() {
        insertCellOnStack()
        removeCellFromCollectionView()
    }
    
    private func removeCellFromCollectionView() {
        establishmentViewController?.establishments.remove(at: (indexPath?.item)!)
        establishmentViewController?.loadingStateOfCellsByUID[(establishment?.uid)!] = nil
        
        establishmentViewController?.collectionView?.deleteItems(at: [indexPath!])        
    }
    
    private func insertCellOnStack() {
        if establishmentViewController?.mainViewController?.setOfEstablishmentUIDsOnStack.contains((self.establishment?.uid)!) == false {
            establishmentViewController?.mainViewController?.setOfEstablishmentUIDsOnStack.insert((self.establishment?.uid)!)
            establishmentViewController?.mainViewController?.stackOfEstablishments.push(self.establishment!)
        }
        UIView.animate(withDuration: 0.5) {
            self.layer.shadowColor = UIColor.clear.cgColor
        }
    }
    // END: Stack
}

















