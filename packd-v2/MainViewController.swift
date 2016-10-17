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
    
    static let establishmentFrameY: CGFloat = 0.0
    static let friendsFrameY: CGFloat = UIScreen.main.bounds.height
    static let perksFrameY: CGFloat = UIScreen.main.bounds.height * 2
    
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
        view.backgroundColor = Colors.background
        
        setupSubViews()
        
        setupEstablishmentViewController()
        
        navigationButtons.setupNavigationButtons(inView: self.view)
        
    }
    
    private func setupSubViews() {
        
        mainScrollView.delegate = self
        view.addSubview(mainScrollView)
        
        for index in 0..<MainViewConstants.backgroundImageDictionary.count {
            
            frame.origin.y = mainScrollView.frame.size.height * CGFloat(index)
            frame.size = mainScrollView.frame.size
            
            let subView = UIView(frame: frame)
            
            
            
            switch index {
            case MainViewConstants.establishmentIndex:
                establishmentContainerView = UIView(frame: frame)
                establishmentContainerView.backgroundColor = Colors.background
                establishmentContainerView.addSubview(establishmentImageView)
                mainScrollView.addSubview(establishmentContainerView)
                

            case MainViewConstants.friendsIndex:
                friendsContainerView = UIView(frame: frame)
                friendsContainerView.backgroundColor = Colors.background
                friendsContainerView.addSubview(friendsImageView)
                mainScrollView.addSubview(friendsContainerView)

            case MainViewConstants.perksIndex:
                subView.addSubview(perksImageView)
                mainScrollView.addSubview(subView)
                subView.backgroundColor = Colors.background
                
            default:
                break
            }
            
            
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
    
    var establishmentContainerView = UIView()
    
    lazy var establishmentCollectionViewController: EstablishmentsViewController? = nil
    
    private func setupEstablishmentViewController() {
        establishmentCollectionViewController = EstablishmentsViewController(collectionViewLayout: MainViewConstants.pageableLayout)
        establishmentCollectionViewController?.setupViewController()
        
        let establishmentView = (establishmentCollectionViewController?.view)!
        establishmentContainerView.addSubview(establishmentView)
        establishmentView.anchorWithConstantsTo(top: establishmentContainerView.topAnchor,
                                                left: establishmentContainerView.leftAnchor,
                                                bottom: establishmentContainerView.bottomAnchor,
                                                right: establishmentContainerView.rightAnchor,
                                                topConstant: 0,
                                                leftConstant: 0,
                                                bottomConstant: 0)
        view.bringSubview(toFront: mainScrollView)
        navigationButtons.bringToFront(ofView: self.view)
        
    }
    
    var friendsContainerView = UIView()
    
    lazy var friendsCollectionViewController: FriendsViewController? = nil
    
    private func setupFriendsViewController() {
        friendsCollectionViewController = FriendsViewController(collectionViewLayout: MainViewConstants.pageableLayout)
        friendsCollectionViewController?.setupViewController()
        
        let friendsView = (friendsCollectionViewController?.view)!
        friendsContainerView.addSubview(friendsView)
        friendsView.anchorWithConstantsTo(top: friendsContainerView.topAnchor,
                                          left: friendsContainerView.leftAnchor,
                                          bottom: friendsContainerView.bottomAnchor,
                                          right: friendsContainerView.rightAnchor,
                                          topConstant: 0,
                                          leftConstant: 0,
                                          bottomConstant: 0)
        view.bringSubview(toFront: mainScrollView)
        navigationButtons.bringToFront(ofView: self.view)
        
    }
    
    let establishmentImageView: UIImageView = {
        return MainViewController.setupBackgroundImage(withImage: MainViewConstants.backgroundImageDictionary[0])
    }()
    
    let friendsImageView: UIImageView = {
        return MainViewController.setupBackgroundImage(withImage: MainViewConstants.backgroundImageDictionary[1])
    }()
    
    let perksImageView: UIImageView = {
        return MainViewController.setupBackgroundImage(withImage: MainViewConstants.backgroundImageDictionary[2])
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
    
    
    let navigationButtonsContianerView = UIView()
    let navigationButtons = NavigationButtons()
    // END: View
    
    
    // START: Collection View Switching
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {        
        switch scrollView.contentOffset.y {
        case MainViewConstants.establishmentFrameY:
            
            friendsCollectionViewController?.view.removeFromSuperview()
            friendsCollectionViewController = nil
            
            if establishmentCollectionViewController == nil {
                setupEstablishmentViewController()
            }
            
        case MainViewConstants.friendsFrameY:
            
            establishmentCollectionViewController?.view.removeFromSuperview()
            establishmentCollectionViewController = nil
            
            if friendsCollectionViewController == nil {
                setupFriendsViewController()
            }
            
        case MainViewConstants.perksFrameY:
            
            friendsCollectionViewController?.view.removeFromSuperview()
            friendsCollectionViewController = nil
            
            
        default:
            break
        }
    }
    // END: Collection View Switching
    
    
}


