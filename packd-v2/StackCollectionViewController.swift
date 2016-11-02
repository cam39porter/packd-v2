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
    // END: Model
    
    // START: View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foldStatesOfCells = [Array<FoldableCellConstants.FoldState>(), Array<FoldableCellConstants.FoldState>()]

        collectionView?.backgroundColor = Colors.highlight
        
        setupFoldStatesOfCells()
        
        collectionView?.register(EstablishmentFoldableCell.self, forCellWithReuseIdentifier: EstablishmentFoldableCell.identifier)
        
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
        setupStackButton()
    }
    
    let stackButton: UIButton = {
        let button = UIButton(type: .custom)
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
    
    private func setupStackButton() {
        addStackButtonToFront(ofView: view)
        anchorStackButton()
        addTargetToStackButton()
    }
    
    private func addStackButtonToFront(ofView view: UIView) {
        view.addSubview(stackButton)
        view.bringSubview(toFront: stackButton)
    }
    
    private func anchorStackButton() {
        stackButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Size.oneFinger).isActive = true
        stackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        stackButton.heightAnchor.constraint(equalToConstant: Size.oneFinger * 2).isActive = true
        stackButton.widthAnchor.constraint(equalToConstant: Size.oneFinger * 2).isActive = true
    }
    
    private func addTargetToStackButton() {
        stackButton.addTarget(self, action: #selector(dismissStackView), for: .touchUpInside)
    }
    
    @objc private func dismissStackView() {
        self.dismiss(animated: true, completion: nil)
        mainViewController?.setupCurrentCollectionView((mainViewController?.mainScrollView)!)
    }
    // END: View
    
    // START: Collection View DataSource Delegate
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
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
                header.titleLabel.text = "And maybe a friend to go there with..."
                header.titleLabel.font = Fonts.lightFont(ofSize: Size.oneFinger / 2)
                header.titleLabel.textAlignment = .center

        default:
            break
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: Size.oneFinger)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return (mainViewController?.stackOfEstablishments.count)!
        case 1:
            return 0
        default:
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EstablishmentFoldableCell.identifier, for: indexPath) as! EstablishmentFoldableCell
        
        // foldable cell setup
        cell.indexPath = indexPath
        cell.collectionViewController = self
        
        // establishment cell setup
        cell.establishment = mainViewController?.stackOfEstablishments.items[indexPath.item]
        
        
        switch foldStatesOfCells[indexPath.section][indexPath.item] {
        case FoldableCellConstants.FoldState.folded:
            cell.setupFolded()
        case FoldableCellConstants.FoldState.halfUnfolded:
            cell.setupHalfUnfolded()
        case FoldableCellConstants.FoldState.fullyUnfolded:
            cell.setupFullyUnfolded()
        }
                
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(Size.oneFinger, 0, 0, 0)
    }
    // END: Collection View DataSource Delegate

}
