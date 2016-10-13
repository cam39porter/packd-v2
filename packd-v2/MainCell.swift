//
//  MainCell.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/6/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

struct MainCellConstants {
    static let establishmentReuseIdentifier: String = "establishmentCell"
    static let friendsReuseIdentifier: String = "friendsCell"
    
    static let establishmentsCellIndex = 0
    static let friendsCellIndex = 1
    static let perksCellIndex = 2
    
    
    static let establishmentImage = UIImage(named: "establishments_bg")
    static let friendsImage = UIImage(named: "friends_bg")
    static let perksImage = UIImage(named: "perks_bg")
    
    static let backgroundImageDictionary: [Int:UIImage] = [MainCellConstants.establishmentsCellIndex : MainCellConstants.establishmentImage!,
                                                           MainCellConstants.friendsCellIndex : MainCellConstants.friendsImage!,
                                                           MainCellConstants.perksCellIndex : MainCellConstants.perksImage!]
    
    static let viewControllerDictionary: [Int:PageableViewController] = [MainCellConstants.establishmentsCellIndex :
                                                                            EstablishmentsViewController(collectionViewLayout:MainCellConstants.layout),
                                                                         MainCellConstants.friendsCellIndex :
                                                                            FriendsViewController(collectionViewLayout: MainCellConstants.layout),
                                                                         MainCellConstants.perksCellIndex :
                                                                            PerksViewController(collectionViewLayout: MainCellConstants.layout)]
    
    static let establishmentIndex = 0
    static let friendsIndex = 1
    static let perksIndex = 2
    
    static let layout: UICollectionViewFlowLayout = {
        let l = CenterCellFlowLayout()
        l.scrollDirection = .horizontal
        return l
    }()
}

class MainCell: UICollectionViewCell {
    
    // START: View
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageView()
    }
    
    func setupImageView() {
        addSubview(imageView)
    }
    
    
    func setCollectionViewController(forIndexPath indexPath: IndexPath, withCollectionVC collectionViewController: PageableViewController?) {
        switch indexPath.item {
        case MainCellConstants.establishmentIndex:
            establishmentCollectionVC = collectionViewController as? EstablishmentsViewController
        case MainCellConstants.friendsIndex:
            friendsCollectionVC = collectionViewController as? FriendsViewController
        default:
            return 
        }
    }
    
    var establishmentCollectionVC: EstablishmentsViewController? {
        willSet {
            newValue?.setupViewController()
        }
        
        didSet {
            self.addSubview((establishmentCollectionVC?.collectionView)!)
            establishmentCollectionVC?.collectionView?.anchorWithConstantsTo(top: self.topAnchor,
                                                                             left: self.leftAnchor,
                                                                             bottom: self.bottomAnchor,
                                                                             right: self.rightAnchor,
                                                                             topConstant: 0,
                                                                             leftConstant: 0,
                                                                             bottomConstant: 0)
        }
    }
    
    var friendsCollectionVC: FriendsViewController? {
        willSet {
            newValue?.setupViewController()
        }
        
        didSet {
            self.addSubview((friendsCollectionVC?.collectionView)!)
            friendsCollectionVC?.collectionView?.anchorWithConstantsTo(top: self.topAnchor,
                                                                             left: self.leftAnchor,
                                                                             bottom: self.bottomAnchor,
                                                                             right: self.rightAnchor,
                                                                             topConstant: 0,
                                                                             leftConstant: 0,
                                                                             bottomConstant: 0)
        }
    }
    
    
    let imageView: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width / 4), y: (UIScreen.main.bounds.height / 3), width: 200, height: 200))
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .white
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 100
        iv.layer.masksToBounds = true
        return iv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // END: view
    
}
