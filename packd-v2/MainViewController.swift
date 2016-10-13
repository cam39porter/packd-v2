//
//  MainViewController.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/6/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

struct MainViewConstants {
    static let establishmentsCellIndex = 0
    static let friendsCellIndex = 1
    static let perksCellIndex = 2
    
    
    static let establishmentImage = UIImage(named: "establishments_bg")
    static let friendsImage = UIImage(named: "friends_bg")
    static let perksImage = UIImage(named: "perks_bg")
    
    static let backgroundImageDictionary: [Int:UIImage] = [MainViewConstants.establishmentsCellIndex : MainViewConstants.establishmentImage!,
                                                           MainViewConstants.friendsCellIndex : MainViewConstants.friendsImage!,
                                                           MainViewConstants.perksCellIndex : MainViewConstants.perksImage!]
    
    static let establishmentIndex = 0
    static let friendsIndex = 1
    static let perksIndex = 2
    
    static let pageableLayout: UICollectionViewFlowLayout = {
        let layout = CenterCellFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
}

class MainViewController: UIViewController, UIScrollViewDelegate {
    
    
    // START: View
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupViews()
        
        navigationButtons.setupNavigationButtons(inView: self.view)
        
    }
    
    private func setupViews() {
        
        view.addSubview(mainScrollView)
        
        for index in 0..<MainViewConstants.backgroundImageDictionary.count {
            
            frame.origin.y = mainScrollView.frame.size.height * CGFloat(index)
            frame.size = mainScrollView.frame.size
            
            let subView = UIView(frame: frame)
            
            
            
            switch index {
            case MainViewConstants.establishmentIndex:
                subView.addSubview(establishmentImageView)
                subView.addSubview(establishmentCollectionViewController.view!)
                establishmentCollectionViewController.view?.anchorWithConstantsTo(top: subView.topAnchor,
                                                                                  left: subView.leftAnchor,
                                                                                  bottom: subView.bottomAnchor,
                                                                                  right: subView.rightAnchor,
                                                                                  topConstant: 0,
                                                                                  leftConstant: 0,
                                                                                  bottomConstant: 0)
            case MainViewConstants.friendsIndex:
                subView.addSubview(friendsImageView)
            case MainViewConstants.perksIndex:
                break
            default:
                break
            }
            
            
            subView.backgroundColor = UIColor.white
            mainScrollView.addSubview(subView)
        }
        
        mainScrollView.contentSize = CGSize(width: mainScrollView.frame.size.width,
                                            height: mainScrollView.frame.size.height * CGFloat(MainViewConstants.backgroundImageDictionary.count))
        
    }
    
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    
    let establishmentCollectionViewController: EstablishmentsViewController = {
        let collectionViewController = EstablishmentsViewController(collectionViewLayout: MainViewConstants.pageableLayout)
        collectionViewController.setupViewController()
        return collectionViewController
    }()
    
    let establishmentImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width / 4), y: (UIScreen.main.bounds.height / 3), width: 200, height: 200))
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 100
        imageView.layer.masksToBounds = true
        imageView.image = MainViewConstants.backgroundImageDictionary[0]
        return imageView
    }()
    
    let friendsImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width / 4), y: (UIScreen.main.bounds.height / 3), width: 200, height: 200))
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 100
        imageView.layer.masksToBounds = true
        imageView.image = MainViewConstants.backgroundImageDictionary[1]
        return imageView
    }()
    
    static func setupBackgroundImage(withImage image: UIImage?) -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width / 4), y: (UIScreen.main.bounds.height / 3), width: 200, height: 200))
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 100
        imageView.layer.masksToBounds = true
        imageView.image = image
        return imageView
    }
    
    
    let navigationButtons = NavigationButtons()
    // END: View
    
    
}


