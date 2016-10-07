//
//  EstablishmentsViewController.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/6/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class EstablishmentsViewController: PageableViewController {
    
    // START: Collection View Datasource
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoldableCellConstants.reuseIdentifier, for: indexPath) as! FoldableCell
        
        cell.backgroundColor = UIColor.black
        
        return cell
    }
    // START: Collection View Datasource
}
