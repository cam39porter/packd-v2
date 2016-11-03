//
//  DateAndTimeCellCollectionViewCell.swift
//  packd-v2
//
//  Created by Cameron Porter on 11/2/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class DateAndTimeCellCollectionViewCell: UICollectionViewCell {
    
    // START: Model
    static let identifier = "dateAndTimeCell"
    
    var currentDate: Date {
        get {
            return Date()
        }
        set {}
    }
    
    var collectionViewController: UICollectionViewController? = nil
    // END: Model
    
    // START: View Components
    func setup() {
        addSubviews()
        anchorSubviews()
        addTargets()
    }
    
    private func addSubviews() {
        addSubview(pickerButton)
    }
    
    private func anchorSubviews() {
        if timeLabel.text != nil {
            anchorPickerButtonEnd()
        } else {
            anchorPickerButtonStart()
        }
    }
    
    private func addTargets() {
        pickerButton.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
    }
    
    let pickerButton: SpringButton = {
        let button = SpringButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.contrast
        button.layer.masksToBounds = false
        let icon = #imageLiteral(resourceName: "date_time_icon")
        let tintIcon = icon.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(tintIcon, for: .normal)
        button.tintColor = Colors.highlight
        button.contentMode = .scaleAspectFit
        button.layer.cornerRadius = Size.oneFinger / 2
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        return button
    }()
    
    private func anchorPickerButtonStart() {
        pickerButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Size.minPadding).isActive = true
        pickerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        pickerButton.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        pickerButton.widthAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
    }
    
    private func anchorPickerButtonEnd() {
        pickerButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: Size.minPadding).isActive = true
        pickerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        pickerButton.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        pickerButton.widthAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
    }
    
    let dateLabel: SpringLabel = {
        let label = SpringLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textColor = Colors.contrast
        label.font = Fonts.font(ofSize: Size.oneFinger / 2)
        label.textAlignment = .left
        return label
    }()
    
    private func anchorDateLabel() {
        dateLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: Size.minPadding / 2).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Size.minPadding).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: Size.oneFinger * 4).isActive = true
    }
    
    let timeLabel: SpringLabel = {
        let label = SpringLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textColor = Colors.contrast
        label.font = Fonts.boldFont(ofSize: Size.oneFinger / 2)
        label.textAlignment = .right
        return label
    }()
    
    private func anchorTimeLabel() {
        timeLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -Size.minPadding / 2).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Size.minPadding).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: Size.oneFinger * 4).isActive = true
    }
    
    // END: View Components
    
    
    // START: Picker 
    @objc private func showPicker() {
        collectionViewController?.collectionView?.scrollToItem(at: (collectionViewController?.collectionView?.indexPath(for: self))!, at: .bottom, animated: true)
                
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 2)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 365)
        let picker = DateTimePicker.show(selected: self.currentDate, minimumDate: min, maximumDate: max)
        picker.highlightColor = Colors.highlight
        picker.doneButtonTitle = "Call it a date"
        picker.todayButtonTitle = "Now    "
        picker.completionHandler = { date in
            
            
            self.currentDate = date
            let formatter = DateFormatter()
            
            formatter.dateFormat = "HH:mm"
            self.timeLabel.text = formatter.string(from: date)
            self.addSubview(self.timeLabel)
            self.anchorTimeLabel()
            
            formatter.dateFormat = "dd/MM"
            self.dateLabel.text = formatter.string(from: date)
            self.addSubview(self.dateLabel)
            self.anchorDateLabel()
            
            self.pickerButton.removeFromSuperview()
            self.addSubview(self.pickerButton)
            self.anchorPickerButtonEnd()
            

            
        }
    }
    // END: Picker
    
}
