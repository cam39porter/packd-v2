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
        
        navigationButtons.setupNavigationButtons(inView: self.view)
        
    }
    
    private func setupViews() {
        view.addSubview(mainCollectionView)
        
        mainCollectionView.anchorTo(top: view.topAnchor,
                                    left: view.leftAnchor,
                                    bottom: view.bottomAnchor,
                                    right: view.rightAnchor)
        
    }

    let navigationButtons = NavigationButtons()
    
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
        
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCellConstants.establishmentReuseIdentifier)
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCellConstants.friendsReuseIdentifier)

        return collectionView
    }()
    // END: View
    
    
    // START: Collection View Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case MainCellConstants.establishmentIndex:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCellConstants.establishmentReuseIdentifier, for: indexPath) as! MainCell
            cell.imageView.image = MainCellConstants.backgroundImageDictionary[indexPath.item]
            
            cell.setCollectionViewController(forIndexPath: indexPath, withCollectionVC: MainCellConstants.viewControllerDictionary[indexPath.item])
            
            return cell
        case MainCellConstants.friendsIndex:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCellConstants.friendsReuseIdentifier, for: indexPath) as! MainCell
            cell.imageView.image = MainCellConstants.backgroundImageDictionary[indexPath.item]
            
            cell.setCollectionViewController(forIndexPath: indexPath, withCollectionVC: MainCellConstants.viewControllerDictionary[indexPath.item])
            
            return cell
        default:
            return UICollectionViewCell()
        }
        
        

    }
    
    // END: Collection View Datasource
    
    
    // START: Collection View Flow Layout Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    // END: Collection View Flow Layout Delegate
}


