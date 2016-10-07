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
    var foldStatesOfCells = Array<FoldableCellConstants.FoldState>()
    var unfoldedCell: IndexPath? = nil
    // END: Model
    
    
    
    // START: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return foldStatesOfCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = FoldableCellConstants.heightOfCell(forState: foldStatesOfCells[indexPath.item])
        let width = FoldableCellConstants.width
        
        return CGSize(width: width, height: height)
    }
    // END: UICollectionViewDataSource
    
}

