//
//  FoldableCell.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/6/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

struct FoldableCellConstants {
    static let foldedHeight: CGFloat = 88
    static let halfUnfoldedHeight: CGFloat = 88 * 2
    static let fullyUnfoldedHeight: CGFloat = 88 * 4
    
    static let width: CGFloat = UIScreen.main.bounds.width - 88
    
    enum FoldState {
        case folded
        case halfUnfolded
        case fullyUnfolded
    }
    
    static func heightOfCell(forState state: FoldState) -> CGFloat {
        switch state {
        case .folded:
            return foldedHeight
        case .halfUnfolded:
            return halfUnfoldedHeight
        case .fullyUnfolded:
            return fullyUnfoldedHeight
        }
    }
    
    static let reuseIdentifier = "foldableCell"
}

class FoldableCell: UICollectionViewCell {
    
    // START: Fold state of the cell
    var isFolded: Bool {
        get {
            return self.frame.size.height == FoldableCellConstants.foldedHeight
        }
    }
    
    var isHalfUnfolded: Bool {
        get {
            return self.frame.size.height == FoldableCellConstants.halfUnfoldedHeight
        }
    }
    
    var isFullyUnfolded: Bool {
        get {
            return self.frame.size.height == FoldableCellConstants.fullyUnfoldedHeight
        }
    }
    
    var foldState: FoldableCellConstants.FoldState? {
        get {
            if isFolded { return FoldableCellConstants.FoldState.folded }
            if isHalfUnfolded { return FoldableCellConstants.FoldState.halfUnfolded }
            if isFullyUnfolded { return FoldableCellConstants.FoldState.fullyUnfolded }
            return nil
        }
    }
    // END: Fold state of the cell
    
    // START: View Controller
    var collectionViewController: FoldableViewController?
    
    var indexPath: IndexPath? = nil
    // END: View Controller
    
    
    // START: View
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup cell
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 10.0
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.backgroundColor = Colors.background
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupFolded() {
        return
    }
    
    func setupHalfUnfolded() {
        setupFolded()
    }
    
    func setupFullyUnfolded() {
        setupHalfUnfolded()
        
    }
    // END: View
    
    
    // START: Folding
    func unfold() {
        if isFolded {
            if let oldUnfoldedCell = collectionViewController?.unfoldedCell {
                collectionViewController?.foldStatesOfCells[oldUnfoldedCell.item] = FoldableCellConstants.FoldState.folded
            }
            collectionViewController?.unfoldedCell = indexPath
            collectionViewController?.foldStatesOfCells[(indexPath?.item)!] = FoldableCellConstants.FoldState.halfUnfolded
            collectionViewController?.collectionView?.reloadData()
        }
        
        if isHalfUnfolded {
            collectionViewController?.unfoldedCell = indexPath
            collectionViewController?.foldStatesOfCells[(indexPath?.item)!] = FoldableCellConstants.FoldState.fullyUnfolded
            collectionViewController?.collectionView?.reloadData()
        }
        
        if isFullyUnfolded { return }
    }
    
    func fold() {
        if isFolded {
            return
        }
        
        if isHalfUnfolded {
            collectionViewController?.unfoldedCell = nil
            collectionViewController?.foldStatesOfCells[(indexPath?.item)!] = FoldableCellConstants.FoldState.folded
            collectionViewController?.collectionView?.reloadData()
        }
        
        if isFullyUnfolded {
            collectionViewController?.unfoldedCell = nil
            collectionViewController?.foldStatesOfCells[(indexPath?.item)!] = FoldableCellConstants.FoldState.folded
            collectionViewController?.collectionView?.reloadData()
        }
    }
    // END: Folding
    
    
    
    
}
