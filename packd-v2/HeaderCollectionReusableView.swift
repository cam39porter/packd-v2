//
//  HeaderCollectionReusableView.swift
//  packd-v2
//
//  Created by Cameron Porter on 11/1/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    // START: Model
    static let identifier = "sectionHeader"
    // END: Model
    
    
    // START: View Components
    func setupHeader() {
        addSubviews()
        anchorSubviews()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
    }
    
    private func anchorSubviews() {
        anchorTitleLabel()
    }
    
    let titleLabel: SpringLabel = {
        let label = SpringLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textColor = Colors.contrast
        label.font = Fonts.lightFont(ofSize: Size.oneFinger)
        label.textAlignment = .left
        label.text = "WHERE"
        return label
    }()
    
    private func anchorTitleLabel() {
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Size.oneFinger).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Size.minPadding).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Size.minPadding).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: Size.oneFinger)
    }
    // END: View Components
    
}
