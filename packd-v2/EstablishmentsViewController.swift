//
//  EstablishmentsViewController.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/6/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class EstablishmentsViewController: PageableViewController {
    
    // START: Model
    var establishments = [Establishment]()
    let cellReuseIdentifier = "establishmentCell"
    // END: Model
    
    // START: View
    override func viewDidLoad() {
        collectionView?.register(EstablishmentCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }
    // END: View
    
    // START: Collection View Datasource
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! EstablishmentCell
        
        cell.establishment = establishments[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return establishments.count
    }
    
    private func fetchEstablishments() {
        Establishment.getAllEstablishments { (establishment) in
            self.establishments.append(establishment!)
            self.collectionView?.reloadData()
        }
    }
    
    override func fetchData() {
        fetchEstablishments()
    }
    // START: Collection View Datasource
}
