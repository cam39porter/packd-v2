//
//  FriendsViewController.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/14/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class FriendsViewController: PageableViewController {
    // START: Model
    var friends = [User]()
    let cellReuseIdentifier = "friendCell"
    
    var loadingStateOfCellsByUID = [String:Bool]()
    var currentLoadState: Bool {
        get {
            
            return loadingStateOfCellsByUID.reduce(false) { (currentLoadState, loadStateOfCell) -> Bool in
                return currentLoadState || loadStateOfCell.value
            }
        }
    }
    
    
    var cellIsLoading = false {
        didSet {
            
            if cellIsLoading {
                view.addSubview(loadingImageView)
                view.sendSubview(toBack: loadingImageView)
                
                UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse, .curveEaseOut], animations: {
                    self.loadingImageView.alpha = 0.5
                    }, completion: nil)
            } else {
                loadingImageView.layer.removeAllAnimations()
                loadingImageView.removeFromSuperview()
            }
        }
    }
    // END: Model
    
    // START: View
    let loadingImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width / 4), y: (UIScreen.main.bounds.height / 3), width: 200, height: 200))
        imageView.backgroundColor = Colors.contrast
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 100
        imageView.layer.masksToBounds = true
        imageView.alpha = 0
        return imageView
    }()
    
    override func viewDidLoad() {
        collectionView?.register(FriendCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }
    // END: View
    
    // START: Collection View Datasource
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! FriendCell
        
        let friend = friends[indexPath.item]
        
        if indexPath.item == loadingStateOfCellsByUID.count {
            loadingStateOfCellsByUID[friend.uid!] = true
        } else {
            loadingStateOfCellsByUID[friend.uid!] = true
        }

        cellIsLoading = true
        cell.alpha = 0
        cell.friendsViewController = self
        cell.friend = friend
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends.count
    }
    
    private func fetchFriends() {
        User.getAllUsers { (friend) in
            self.friends.append(friend!)
            self.collectionView?.reloadData()
        }
    }
    
    override func fetchData() {
        fetchFriends()
    }
    // END: Collection View Datasource
    
    
}
