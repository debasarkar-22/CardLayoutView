//
//  CardViewDataSource.swift
//  CardLayoutView
//
//  Created by Debaditya  Sarkar on 11/27/17.
//  Copyright © 2017 Debaditya. All rights reserved.
//

import Foundation

class CardViewDataSource : NSObject, UICollectionViewDataSource {
    
    // Properties
    var viewControllers: [UIViewController] = []
    var headers: [UIView] = []
    
    var shadowRadius: CGFloat = 5.0
    var shadowOpacity: CGFloat = 1.0
    var shadowHeight: CGFloat = 2.0
    var shadowColor: CGColor = UIColor.lightGray.cgColor
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // Code to add shadow to give floating in the air effect
        cell.contentView.layer.masksToBounds = true;
        cell.layer.shadowColor = shadowColor
        cell.layer.shadowOffset = CGSize(width:0,height: shadowHeight)
        cell.layer.shadowRadius = shadowRadius
        cell.layer.shadowOpacity = Float(shadowOpacity)
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(rect:cell.bounds).cgPath
        
        // Populating the content of the card
        cell.contentViewController = viewControllers[indexPath.item]
        viewControllers[indexPath.item].view.frame = cell.contentView.bounds
        cell.populateCell()
        
        return cell
    }
}
