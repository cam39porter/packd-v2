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
    // END: Model
    
    // START: View Components
    func setup() {
        addSubviews()
        anchorSubviews()
    }
    
    private func addSubviews() {
        addSubview(pickerButton)
    }
    
    private func anchorSubviews() {
        anchorPickerButton()
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
    
    private func anchorPickerButton() {
        pickerButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Size.minPadding).isActive = true
        pickerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        pickerButton.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        pickerButton.widthAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
    }
    // END: View Components
    
    
    // START: Picker 
    private func showPicker() {
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 365)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 365)
        let picker = DateTimePicker.show(selected: self.currentDate, minimumDate: min, maximumDate: max)
        picker.highlightColor = Colors.highlight
        picker.doneButtonTitle = "!! DONE DONE !!"
        picker.todayButtonTitle = "Today👌Today"
        picker.completionHandler = { date in
            self.currentDate = date
            //            let formatter = DateFormatter()
            //            formatter.dateFormat = "HH:mm dd/MM/YYYY"
            //            self.item.title = formatter.string(from: date)
        }
    }
    // END: Picker
    
}
