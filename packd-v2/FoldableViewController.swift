//
//  FoldableViewController.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/6/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//


import UIKit

class FoldableViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // START: Model
    var foldStatesOfCells = [Array<FoldableCellConstants.FoldState>()]
    var unfoldedCell: IndexPath? = nil
    // END: Model
    
    // START: View 
    override func viewDidLoad() {
        collectionView?.alwaysBounceVertical = true
    }
    func setupViewController() {}
    // END: View
    
    // START: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = FoldableCellConstants.heightOfCell(forState: foldStatesOfCells[indexPath.section][indexPath.item])
        let width = FoldableCellConstants.width
        return CGSize(width: width, height: height)
    }
    // END: UICollectionViewDataSource
    
}

