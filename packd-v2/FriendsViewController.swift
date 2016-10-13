//
//  FriendsViewController.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/7/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class FriendsViewController: PageableViewController {
    
    // START: Collection View Datasource
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoldableCellConstants.reuseIdentifier, for: indexPath) as! FoldableCell
        
        cell.backgroundColor = UIColor.gray
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    // START: Collection View Datasource
}
