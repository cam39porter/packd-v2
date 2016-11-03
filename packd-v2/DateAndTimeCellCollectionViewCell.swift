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
        if dateTimeLabel.text != nil {
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
        pickerButton.topAnchor.constraint(equalTo: dateTimeLabel.bottomAnchor, constant: Size.minPadding).isActive = true
        pickerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        pickerButton.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        pickerButton.widthAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
    }
    
    let dateTimeLabel: SpringLabel = {
        let label = SpringLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textColor = Colors.contrast
        label.font = Fonts.boldFont(ofSize: Size.oneFinger / 2)
        label.textAlignment = .center
        return label
    }()
    
    private func anchorDateTimeLabel() {
        dateTimeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        dateTimeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Size.minPadding).isActive = true
        dateTimeLabel.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        dateTimeLabel.widthAnchor.constraint(equalToConstant: Size.oneFinger * 4).isActive = true
    }
    
    // END: View Components
    
    
    // START: Picker 
    @objc private func showPicker() {
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 2)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 365)
        let picker = DateTimePicker.show(selected: self.currentDate, minimumDate: min, maximumDate: max)
        picker.highlightColor = Colors.highlight
        picker.doneButtonTitle = "!! DONE DONE !!"
        picker.todayButtonTitle = "Today👌Today"
        picker.completionHandler = { date in
            
            
            self.currentDate = date
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm dd/MM/YYYY"
            
            self.dateTimeLabel.text = formatter.string(from: date)
            self.addSubview(self.dateTimeLabel)
            self.anchorDateTimeLabel()
            
            self.pickerButton.removeFromSuperview()
            self.addSubview(self.pickerButton)
            self.anchorPickerButtonEnd()
            

            
        }
    }
    // END: Picker
    
}
