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
    var stackOfFoldableCells: Stack<FoldableCell>? = nil
    // END: Model
    
    // START: View
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.white
        
        collectionView?.register(FoldableCell.self, forCellWithReuseIdentifier: FoldableCellConstants.reuseIdentifier)
    }
    // END: View
    
    // START: Collection View DataSource Delegate
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foldStatesOfCells.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoldableCellConstants.reuseIdentifier, for: indexPath)
        
        return cell
        
    }
    // END: Collection View DataSource Delegate

}
