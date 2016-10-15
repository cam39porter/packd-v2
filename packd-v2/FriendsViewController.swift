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
    
    // END: Model
    
    // START: View
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
        
        // set up the cell
        
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
