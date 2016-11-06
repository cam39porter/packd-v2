//
//  DateAndTimeCellCollectionViewCell.swift
//  packd-v2
//
//  Created by Cameron Porter on 11/2/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit
import AudioToolbox

class DateAndTimeCellCollectionViewCell: UICollectionViewCell {
    
    // START: Model
    
    var collectionViewController: UICollectionViewController? = nil
    
    static let identifier = "dateAndTimeCell"
    
    var minutes = 0 {
        didSet {
            
            if minutes == 0 {
                timeLabel.text = "Right now!"
                inLabel.text = ""
            } else {
                
                let hours = minutes / 60
                let remainingMinutes = minutes % 60
                
                if hours == 0 {
                    timeLabel.text = String(minutes) + " mins"
                } else if hours == 1 {
                    timeLabel.text = String(hours) + " hour"
                    if remainingMinutes > 0 {
                        timeLabel.text = timeLabel.text! + " " + String(remainingMinutes) + " mins"
                    }
                } else {
                    timeLabel.text = String(hours) + " hours"
                    if remainingMinutes > 0 {
                        timeLabel.text = timeLabel.text! + " " + String(remainingMinutes) + " mins"
                    }
                }
                
                inLabel.text = "IN"
            }
        }
    }
    
    // END: Model
    
    
    // START: View Components
    
    func setup() {
        addSubviews()
        anchorSubviews()
        addTargets()
        
    }
    
    private func addSubviews() {
        self.addSubview(inLabel)
        self.addSubview(timeLabel)
        
        self.addSubview(fiveMinButton)
        self.addSubview(tenMinButton)
        self.addSubview(fifteenMinButton)
        self.addSubview(thirtyMinButton)
        self.addSubview(oneHourButton)
        self.addSubview(twoHourButton)
        
    }
    
    private func anchorSubviews() {
        anchorInButton()
        anchorTimeLabel()
        
        anchorTenMinButton()
        anchorFiveMinButton()
        anchorFifteenMinButton()
        anchorThirtyMinButton()
        anchorOneHourButton()
        anchorTwoHourButton()
    }
    
    private func addTargets() {
        addTargetsToMinuteButtons()
    }
    
    let inLabel: SpringLabel = {
        let label = SpringLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textColor = Colors.contrast
        label.font = Fonts.boldFont(ofSize: Size.oneFinger / 2)
        label.textAlignment = .left
        label.text = ""
        return label
    }()
    
    private func anchorInButton() {
        inLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Size.oneFinger).isActive = true
        inLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Size.minPadding * 2).isActive = true
        inLabel.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        inLabel.widthAnchor.constraint(equalToConstant: Size.oneFinger * 2).isActive = true
        
    }
    
    let timeLabel: SpringLabel = {
        let label = SpringLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textColor = Colors.contrast
        label.font = Fonts.font(ofSize: Size.oneFinger / 2)
        label.textAlignment = .center
        label.text = "Right now!"
        return label
    }()
    
    private func anchorTimeLabel() {
        timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: inLabel.centerYAnchor, constant: 0).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: Size.oneFinger * 4).isActive = true
        
    }
    
    @objc private func performHighlight(button: SpringButton) {
        AudioServicesPlaySystemSound(1520)
        
        button.backgroundColor = Colors.highlight
        button.setTitleColor(Colors.contrast, for: .normal)
        button.layer.shadowColor = Colors.contrast.cgColor
        
        switch button {
        case fiveMinButton:
            minutes += 5
        case tenMinButton:
            minutes += 10
        case fifteenMinButton:
            minutes += 15
        case thirtyMinButton:
            minutes += 30
        case oneHourButton:
            minutes += 60
        case twoHourButton:
            minutes += 120
        default:
            return
        }
    }
    
    @objc private func performUnhighlight(button: SpringButton) {
        button.backgroundColor = Colors.contrast
        button.setTitleColor(Colors.highlight, for: .normal)
        button.layer.shadowColor = UIColor.clear.cgColor
        
        switch button {
        case fiveMinButton:
            minutes -= 5
        case tenMinButton:
            minutes -= 10
        case fifteenMinButton:
            minutes -= 15
        case thirtyMinButton:
            minutes -= 30
        case oneHourButton:
            minutes -= 60
        case twoHourButton:
            minutes -= 120
        default:
            return
        }
    }
    
    let fiveMinButton: SpringButton = {
        let button = SpringButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.contrast
        button.setTitle("5", for: .normal)
        button.setTitleColor(Colors.highlight, for: .normal)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        return button
    }()
    
    private func anchorFiveMinButton() {
        fiveMinButton.rightAnchor.constraint(equalTo: tenMinButton.leftAnchor, constant: -Size.oneFinger).isActive = true
        fiveMinButton.topAnchor.constraint(equalTo: inLabel.bottomAnchor, constant: Size.minPadding * 2).isActive = true
        fiveMinButton.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        fiveMinButton.widthAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        
    }
    
    let tenMinButton: SpringButton = {
        let button = SpringButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.contrast
        button.setTitle("10", for: .normal)
        button.setTitleColor(Colors.highlight, for: .normal)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        return button
    }()
    
    private func anchorTenMinButton() {
        tenMinButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        tenMinButton.topAnchor.constraint(equalTo: inLabel.bottomAnchor, constant: Size.minPadding * 2).isActive = true
        tenMinButton.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        tenMinButton.widthAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        
    }
    
    let fifteenMinButton: SpringButton = {
        let button = SpringButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.contrast
        button.setTitle("15", for: .normal)
        button.setTitleColor(Colors.highlight, for: .normal)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        return button
    }()
    
    private func anchorFifteenMinButton() {
        fifteenMinButton.leftAnchor.constraint(equalTo: tenMinButton.rightAnchor, constant: Size.oneFinger).isActive = true
        fifteenMinButton.topAnchor.constraint(equalTo: inLabel.bottomAnchor, constant: Size.minPadding * 2).isActive = true
        fifteenMinButton.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        fifteenMinButton.widthAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        
    }
    
    let thirtyMinButton: SpringButton = {
        let button = SpringButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.contrast
        button.setTitle("30", for: .normal)
        button.setTitleColor(Colors.highlight, for: .normal)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        return button
    }()
    
    private func anchorThirtyMinButton() {
        thirtyMinButton.rightAnchor.constraint(equalTo: oneHourButton.leftAnchor, constant: -Size.oneFinger).isActive = true
        thirtyMinButton.topAnchor.constraint(equalTo: tenMinButton.bottomAnchor, constant: Size.minPadding * 2).isActive = true
        thirtyMinButton.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        thirtyMinButton.widthAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        
    }
    
    let oneHourButton: SpringButton = {
        let button = SpringButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.contrast
        button.setTitle("1h", for: .normal)
        button.setTitleColor(Colors.highlight, for: .normal)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        return button
    }()
    
    private func anchorOneHourButton() {
        oneHourButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        oneHourButton.topAnchor.constraint(equalTo: tenMinButton.bottomAnchor, constant: Size.minPadding * 2).isActive = true
        oneHourButton.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        oneHourButton.widthAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        
    }
    
    let twoHourButton: SpringButton = {
        let button = SpringButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.contrast
        button.setTitle("2h", for: .normal)
        button.setTitleColor(Colors.highlight, for: .normal)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        return button
    }()
    
    private func anchorTwoHourButton() {
        twoHourButton.leftAnchor.constraint(equalTo: oneHourButton.rightAnchor, constant: Size.oneFinger).isActive = true
        twoHourButton.topAnchor.constraint(equalTo: tenMinButton.bottomAnchor, constant: Size.minPadding * 2).isActive = true
        twoHourButton.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        twoHourButton.widthAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        
    }
    
    private func addTargetsToMinuteButtons() {
        fiveMinButton.addTarget(self, action: #selector(highlightMinuteButton(button:)), for: .touchUpInside)
        tenMinButton.addTarget(self, action: #selector(highlightMinuteButton(button:)), for: .touchUpInside)
        fifteenMinButton.addTarget(self, action: #selector(highlightMinuteButton(button:)), for: .touchUpInside)
        thirtyMinButton.addTarget(self, action: #selector(highlightMinuteButton(button:)), for: .touchUpInside)
        oneHourButton.addTarget(self, action: #selector(highlightMinuteButton(button:)), for: .touchUpInside)
        twoHourButton.addTarget(self, action: #selector(highlightMinuteButton(button:)), for: .touchUpInside)
    }
    
    @objc private func highlightMinuteButton(button: SpringButton) {
        
        switch button.backgroundColor! {
        case Colors.contrast:
            performHighlight(button: button)
        case Colors.highlight:
            performUnhighlight(button: button)
        default:
            return
        }
    }
    // END: View Components
    

    
}
