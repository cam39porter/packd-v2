//
//  StackCollectionViewController.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/19/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class StackCollectionViewController: FoldableViewController {
    // START: Model
    var mainViewController: MainViewController? = nil
    
    var dateAndTimeCell: DateAndTimeCellCollectionViewCell? = nil
    // END: Model
    
    // START: View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foldStatesOfCells = [Array<FoldableCellConstants.FoldState>(), Array<FoldableCellConstants.FoldState>()]

        collectionView?.backgroundColor = Colors.highlight
        
        setupFoldStatesOfCells()
        
        collectionView?.register(EstablishmentFoldableCell.self, forCellWithReuseIdentifier: EstablishmentFoldableCell.identifier)
        collectionView?.register(FriendFoldableCell.self, forCellWithReuseIdentifier: FriendFoldableCell.identifier)
        collectionView?.register(DateAndTimeCellCollectionViewCell.self, forCellWithReuseIdentifier: DateAndTimeCellCollectionViewCell.identifier)
        
        collectionView?.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        setupSubViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainViewController?.clearCurrentCollectionView((mainViewController?.mainScrollView)!)
    }
    
    private func setupFoldStatesOfCells() {
        var cellCount = (mainViewController?.stackOfEstablishments.count)!
        if cellCount != 0 {
            for _ in 1...cellCount { foldStatesOfCells[0].append(FoldableCellConstants.FoldState.folded) }
        }
        
        cellCount = (mainViewController?.stackOfFriends.count)!
        if cellCount != 0 {
            for _ in 1...cellCount { foldStatesOfCells[1].append(FoldableCellConstants.FoldState.folded) }
        }
        
        
    }
    
    private func setupSubViews() {
        setupStackButtons()
    }
    
    let stackButton: SpringButton = {
        let button = SpringButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.contrast
        button.setTitle("-", for: .normal)
        button.setTitleColor(Colors.highlight, for: .normal)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = Size.oneFinger
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        return button
    }()
    
    let sendButton: SpringButton = {
        let button = SpringButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        let icon = #imageLiteral(resourceName: "send_icon")
        let tintIcon = icon.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(tintIcon, for: .normal)
        button.tintColor = Colors.contrast
        button.layer.masksToBounds = false
        button.layer.cornerRadius = Size.oneFinger / 2
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        return button
    }()
    
    let clearButton: SpringButton = {
        let button = SpringButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        let icon = #imageLiteral(resourceName: "clear_icon")
        let tintIcon = icon.withRenderingMode(.alwaysTemplate)
        button.setBackgroundImage(tintIcon, for: .normal)
        button.tintColor = Colors.contrast
        button.contentMode = .scaleAspectFit
        button.layer.masksToBounds = false
        button.layer.cornerRadius = Size.oneFinger / 2
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        return button
    }()
    
    private func setupStackButtons() {
        addStackButtonsToFront(ofView: view)
        anchorStackButtons()
        addTargetToStackButtons()
    }
    
    private func addStackButtonsToFront(ofView view: UIView) {
        view.addSubview(stackButton)
        view.bringSubview(toFront: stackButton)
        
        view.addSubview(sendButton)
        view.bringSubview(toFront: sendButton)
        
        view.addSubview(clearButton)
        view.bringSubview(toFront: clearButton)
    }
    
    private func anchorStackButtons() {
        stackButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Size.oneFinger).isActive = true
        stackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        stackButton.heightAnchor.constraint(equalToConstant: Size.oneFinger * 2).isActive = true
        stackButton.widthAnchor.constraint(equalToConstant: Size.oneFinger * 2).isActive = true
        
        sendButton.leftAnchor.constraint(equalTo: stackButton.rightAnchor, constant: Size.oneFinger).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: stackButton.centerYAnchor, constant: 0).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        
        clearButton.rightAnchor.constraint(equalTo: stackButton.leftAnchor, constant: -Size.oneFinger).isActive = true
        clearButton.centerYAnchor.constraint(equalTo: stackButton.centerYAnchor, constant: 0).isActive = true
        clearButton.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        clearButton.widthAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
    }
    
    private func addTargetToStackButtons() {
        stackButton.addTarget(self, action: #selector(dismissStackView), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(send), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clear), for: .touchUpInside)
    }
    
    @objc private func send() {
        sendButton.animation = Spring.AnimationPreset.Wobble.rawValue
        sendButton.force = 0.25
        sendButton.animate()
        
        
    }
    
    @objc private func clear() {
        clearButton.animation = Spring.AnimationPreset.Wobble.rawValue
        clearButton.force = 0.25
        clearButton.animate()
        
        mainViewController?.setOfFriendsUIDsOnStack.removeAll()
        mainViewController?.stackOfFriends.items.removeAll()
        
        mainViewController?.setOfEstablishmentUIDsOnStack.removeAll()
        mainViewController?.stackOfEstablishments.items.removeAll()
        
        mainViewController?.dateAndTimeCell = nil
        
        collectionView?.reloadData()
    }
    
    @objc private func dismissStackView() {
        self.dismiss(animated: true, completion: nil)
        mainViewController?.setupCurrentCollectionView((mainViewController?.mainScrollView)!)
    }
    // END: View
    
    // START: Collection View DataSource Delegate
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        
        header.setupHeader()
        
        switch indexPath.section {
        case 0:
            if (mainViewController?.stackOfEstablishments.count)! == 0 {
                header.titleLabel.text = "Go back and choose somewhere to go..."
                header.titleLabel.font = Fonts.lightFont(ofSize: Size.oneFinger / 2)
                header.titleLabel.textAlignment = .center
            } else {
                header.titleLabel.text = "WHERE"
                header.titleLabel.font = Fonts.lightFont(ofSize: Size.oneFinger)
                header.titleLabel.textAlignment = .left
            }
        case 1:
            
            if (mainViewController?.stackOfFriends.count)! == 0 {
                header.titleLabel.text = "And maybe a friend to go there with..."
                header.titleLabel.font = Fonts.lightFont(ofSize: Size.oneFinger / 2)
                header.titleLabel.textAlignment = .center
            } else {
                header.titleLabel.text = "WITH"
                header.titleLabel.font = Fonts.lightFont(ofSize: Size.oneFinger)
                header.titleLabel.textAlignment = .left
            }

        default:
            header.titleLabel.text = "P.S. pick a time to meet up..."
            header.titleLabel.font = Fonts.lightFont(ofSize: Size.oneFinger / 2)
            header.titleLabel.textAlignment = .center
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: Size.oneFinger)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0, 1:
            let height = FoldableCellConstants.heightOfCell(forState: foldStatesOfCells[indexPath.section][indexPath.item])
            let width = FoldableCellConstants.width
            return CGSize(width: width, height: height)

        default:
            let height = 430.0
            let width = Double((self.collectionView?.frame.width)!)
            return CGSize(width: width, height: height)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return (mainViewController?.stackOfEstablishments.count)!
        case 1:
            return (mainViewController?.stackOfFriends.count)!
        default:
            return 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EstablishmentFoldableCell.identifier, for: indexPath) as! EstablishmentFoldableCell
            cell.establishment = mainViewController?.stackOfEstablishments.items[indexPath.item]
            setup(cell: cell, withIndexPath: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendFoldableCell.identifier, for: indexPath) as! FriendFoldableCell
            cell.friend = mainViewController?.stackOfFriends.items[indexPath.item]
            setup(cell: cell, withIndexPath: indexPath)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateAndTimeCellCollectionViewCell.identifier, for: indexPath) as! DateAndTimeCellCollectionViewCell
            
            if let dateAndTimeCell = mainViewController?.dateAndTimeCell {
                if dateAndTimeCell.fiveMinButton.backgroundColor == Colors.highlight {
                    cell.performHighlight(button: cell.fiveMinButton)
                }
                if dateAndTimeCell.tenMinButton.backgroundColor == Colors.highlight {
                    cell.performHighlight(button: cell.tenMinButton)
                }
                if dateAndTimeCell.fifteenMinButton.backgroundColor == Colors.highlight {
                    cell.performHighlight(button: cell.fifteenMinButton)
                }
                if dateAndTimeCell.thirtyMinButton.backgroundColor == Colors.highlight {
                    cell.performHighlight(button: cell.thirtyMinButton)
                }
                if dateAndTimeCell.oneHourButton.backgroundColor == Colors.highlight {
                    cell.performHighlight(button: cell.oneHourButton)
                }
                if dateAndTimeCell.twoHourButton.backgroundColor == Colors.highlight {
                    cell.performHighlight(button: cell.twoHourButton)
                }
            }
            
            dateAndTimeCell = cell
            cell.collectionViewController = self
            cell.setup()
            mainViewController?.dateAndTimeCell = cell
            return cell
        }
        
        
    }
    
    private func setup(cell: FoldableCell, withIndexPath indexPath: IndexPath) {
        cell.collectionViewController = self
        
        switch foldStatesOfCells[indexPath.section][indexPath.item] {
        case FoldableCellConstants.FoldState.folded:
            cell.setupFolded()
        case FoldableCellConstants.FoldState.halfUnfolded:
            cell.setupHalfUnfolded()
        case FoldableCellConstants.FoldState.fullyUnfolded:
            cell.setupFullyUnfolded()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(Size.oneFinger, 0, 0, 0)
    }
    // END: Collection View DataSource Delegate

}
