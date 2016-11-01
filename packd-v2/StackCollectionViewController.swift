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

        collectionView?.backgroundColor = Colors.highlight
        
        setupFoldStatesOfCells()
        
        collectionView?.register(EstablishmentFoldableCell.self, forCellWithReuseIdentifier: FoldableCellConstants.reuseIdentifier)
        
        setupSubViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainViewController?.clearCurrentCollectionView((mainViewController?.mainScrollView)!)
    }
    
    private func setupFoldStatesOfCells() {
        let cellCount = (mainViewController?.stackOfEstablishments.count)!
        if cellCount == 0 { return }
        for _ in 1...cellCount { foldStatesOfCells.append(FoldableCellConstants.FoldState.folded) }
    }
    
    private func setupSubViews() {
        setupStackButton()
    }
    
    let stackButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.contrast
        button.setTitle("x", for: .normal)
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
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (mainViewController?.stackOfEstablishments.count)!
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoldableCellConstants.reuseIdentifier, for: indexPath) as! EstablishmentFoldableCell
        
        // foldable cell setup
        cell.indexPath = indexPath
        cell.collectionViewController = self
        
        // establishment cell setup
        cell.establishment = mainViewController?.stackOfEstablishments.items[indexPath.item]
        
        
        switch foldStatesOfCells[indexPath.item] {
        case FoldableCellConstants.FoldState.folded:
            cell.setupFolded()
        case FoldableCellConstants.FoldState.halfUnfolded:
            cell.setupHalfUnfolded()
        case FoldableCellConstants.FoldState.fullyUnfolded:
            cell.setupFullyUnfolded()
        }
        
        cell.setupFolded()
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(Size.oneFinger, 0, 0, 0)
    }
    // END: Collection View DataSource Delegate

}
