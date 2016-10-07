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
        
        switch indexPath.item {
        case 0:
            cell.imageView.image = MainCellConstants.backgroundImageDictionary[indexPath.item]
            cell.collectionViewController = EstablishmentsViewController(collectionViewLayout: cell.layout)
        case 1:
            cell.imageView.image = MainCellConstants.backgroundImageDictionary[indexPath.item]
        case 3:
            cell.imageView.image = MainCellConstants.backgroundImageDictionary[indexPath.item]
        default:
            break
        }
        
        
        return cell
    }
    // END: Collection View Datasource
    
    
    // START: Collection View Flow Layout Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    // END: Collection View Flow Layout Delegate
}

