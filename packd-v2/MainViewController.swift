//
//  MainViewController.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/6/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    // START: View
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(mainCollectionView)
        
        mainCollectionView.anchorTo(top: view.topAnchor,
                                    left: view.leftAnchor,
                                    bottom: view.bottomAnchor,
                                    right: view.rightAnchor)
        
    }
    
    lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false 
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCellConstants.reuseIdentifier)

        return collectionView
    }()
    
    // END: View
    
    
    // START: Collection View Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCellConstants.reuseIdentifier, for: indexPath) as! MainCell
        cell.imageView.image = MainCellConstants.backgroundImageDictionary[indexPath.item]
        cell.collectionViewController = MainCellConstants.viewControllerDictionary[indexPath.item]
        return cell
    }
    
    // END: Collection View Datasource
    
    
    // START: Collection View Flow Layout Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    var lastVisibleItemIndexPath: IndexPath? = nil
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(mainCollectionView.indexPathsForVisibleItems)
        
        let visibleIndexPath = mainCollectionView.indexPathsForVisibleItems[0]
       
        if lastVisibleItemIndexPath == nil {
            print("setting last visible index \(visibleIndexPath)")
            lastVisibleItemIndexPath = visibleIndexPath
        } else if lastVisibleItemIndexPath == visibleIndexPath {
            return
        }
        
        if let lastVisibleCell = mainCollectionView.cellForItem(at: lastVisibleItemIndexPath!) as? FoldableCell {
            print("preparing cell for reuse")
            lastVisibleCell.prepareForReuse()
        }
        
        if let visibleCell = mainCollectionView.cellForItem(at: visibleIndexPath) as? FoldableCell {
            print("adding view controller")
            MainCellConstants.viewControllerDictionary[visibleIndexPath.item]?.collectionView?.reloadData()
            visibleCell.collectionViewController = MainCellConstants.viewControllerDictionary[visibleIndexPath.item]
        }
        
        // update last visible index path 
        
    }
    // END: Collection View Flow Layout Delegate
}

