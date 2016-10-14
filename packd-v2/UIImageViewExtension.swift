//
//  UIImageExtension.swift
//  PACKD
//
//  Created by Cameron Porter on 9/20/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageWithCacheFor(urlString: String) {
        
        self.image = nil
        
        // check to see if the image has been cached on the device already
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // otherwise need to download from Firebase
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            // there was an error downloading
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
            })
            }.resume()
    }
    
    func getImageWithCacheFor(urlString: String, completion: @escaping ((_ image: UIImage?) -> Void)) {
        
        // check to see if the image has been cached on the device already
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            completion(cachedImage)
        }
        
        // otherwise need to download from Firebase
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            // there was an error downloading
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let downloadedImage = UIImage(data: data!) {
                imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                completion(downloadedImage)
            }
            
            }.resume()
    }
}
