//
//  PageableViewController.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/6/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class PageableViewController: FoldableViewController {
    
    
    // START: Pageable
    override func setupViewController() {
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
        var insets = collectionView?.contentInset
        let value = (view.frame.width - FoldableCellConstants.width) * 0.5
        insets?.left = value
        insets?.right = value
        collectionView?.contentInset = insets!
        collectionView?.alwaysBounceVertical = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.backgroundColor = UIColor.clear
    }
    // END: Pageable
    
    // START: Collection View Datasource
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = FoldableCellConstants.fullyUnfoldedHeight
        let width =  FoldableCellConstants.width
        
        return CGSize(width: width, height: height)
    }
    
    func fetchData(){}
    // END: Collection VIew Datasource

}