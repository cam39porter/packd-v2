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
    var hearts = [Heart?]()
    let cellReuseIdentifier = "establishmentCell"
    
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
    
    var isAddingCellToStack = false
    var mainViewController: MainViewController? = nil
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
        collectionView?.register(EstablishmentCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        fetchData()
    }
    // END: View
    
    // START: Collection View Datasource
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! EstablishmentCell
        
        let establishment = establishments[indexPath.item]
        
        if indexPath.item == loadingStateOfCellsByUID.count {
            loadingStateOfCellsByUID[establishment.uid!] = true
        } else {
            loadingStateOfCellsByUID[establishment.uid!] = true
        }
        
        cellIsLoading = true
        cell.alpha = 0
        cell.establishmentViewController = self
        cell.establishment = establishment
        cell.heart = hearts[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return establishments.count
    }
    
    private func fetchEstablishments() {
        Establishment.getAllEstablishments { (establishment) in
            
            
            User.isHearted(byUserWithUID: User.getCurrentUserUID()!, forEstablishmentUID: establishment?.uid!, withCompletionHandler: { (heart) in
                self.establishments.append(establishment!)
                self.hearts.append(heart)
                self.collectionView?.reloadData()
            })
        }
    }
    
    override func fetchData() {
        fetchEstablishments()
    }
    // START: Collection View Datasource
}
