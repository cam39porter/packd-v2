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

class MainViewController: UIViewController, UIScrollViewDelegate, UIViewControllerTransitioningDelegate {
    
    // START: Model
    var stackOfFoldableCells = Stack<FoldableCell>()
    // END: Model
    
    // START: View
    override func viewDidAppear(_ animated: Bool) {
        presentLoginIfUserIsNotLoggedIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupSubViews()
        
        setupEstablishmentViewController()
        
        navigationButtons.setupNavigationButtons(inView: self.view)
        
        setupStackButton()
        
    }
    
    private func presentLoginIfUserIsNotLoggedIn() {
        if Authorization.isUserLoggedIn() {
            return
        } else {
            present(LoginViewController(), animated: false, completion: nil)
        }
        
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
                establishmentContainerView.backgroundColor = UIColor.white
                establishmentContainerView.addSubview(establishmentImageView)
                mainScrollView.addSubview(establishmentContainerView)
                

            case MainViewConstants.friendsIndex:
                friendsContainerView = UIView(frame: frame)
                friendsContainerView.backgroundColor = UIColor.white
                friendsContainerView.addSubview(friendsImageView)
                mainScrollView.addSubview(friendsContainerView)

            case MainViewConstants.perksIndex:
                subView.addSubview(perksImageView)
                mainScrollView.addSubview(subView)
                subView.backgroundColor = UIColor.white
                
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
        
        establishmentCollectionViewController?.mainViewController = self
        
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
        view.bringSubview(toFront: stackButton)
        
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
        view.bringSubview(toFront: stackButton)
        
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
    
    
    func clearCurrentCollectionView(_ scrollView: UIScrollView) {
        switch scrollView.contentOffset.y {
        case MainViewConstants.establishmentFrameY:
            
            establishmentCollectionViewController?.view.removeFromSuperview()
            establishmentCollectionViewController = nil
            
        case MainViewConstants.friendsFrameY:
            
            friendsCollectionViewController?.view.removeFromSuperview()
            friendsCollectionViewController = nil
            
        case MainViewConstants.perksFrameY:
            
            break
            
        default:
            break
        }
    }
    
    func setupCurrentCollectionView(_ scrollView: UIScrollView) {
        switch scrollView.contentOffset.y {
        case MainViewConstants.establishmentFrameY:
            
            setupEstablishmentViewController()
            
        case MainViewConstants.friendsFrameY:
            
            setupFriendsViewController()
            
        case MainViewConstants.perksFrameY:
            
            break
            
        default:
            break
        }
    }
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
    
    // START: Stack
    let stackButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.highlight
        button.setTitle("+", for: .normal)
        button.setTitleColor(Colors.contrast, for: .normal)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = Size.oneFinger
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        return button
    }()
    
    private func setupStackButton() {
        addStackButtonToFront(ofView: view)
        anchorStackButton()
        addTargetToStackButton()
    }
    
    private func addStackButtonToFront(ofView view: UIView) {
        view.addSubview(stackButton)
        view.bringSubview(toFront: stackButton)
    }
    
    private func anchorStackButton() {
        stackButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Size.oneFinger).isActive = true
        stackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        stackButton.heightAnchor.constraint(equalToConstant: Size.oneFinger * 2).isActive = true
        stackButton.widthAnchor.constraint(equalToConstant: Size.oneFinger * 2).isActive = true
    }
    
    private func addTargetToStackButton() {
        stackButton.addTarget(self, action: #selector(presentStackView), for: .touchUpInside)
    }
    
    @objc private func presentStackView() {
        let stackCollectionViewController = StackCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        stackCollectionViewController.mainViewController = self
        stackCollectionViewController.modalPresentationStyle = .custom
        stackCollectionViewController.transitioningDelegate = self
        present(stackCollectionViewController, animated: true, completion: nil)
    }
    // END: Stack
    
    // Start: Circular Transition
    let transition = CircularTransition()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = stackButton.center
        transition.circleColor = stackButton.backgroundColor!
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = stackButton.center
        transition.circleColor = stackButton.backgroundColor!
        return transition
    }
    // END: Circular Transition
}


