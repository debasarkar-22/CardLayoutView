//
//  CardLayoutManager.swift
//  CardLayoutView
//
//  Created by Debaditya  Sarkar on 11/29/17.
//  Copyright © 2017 Debaditya. All rights reserved.
//

import UIKit

public class CardLayoutManager: NSObject {
    public static let shared = CardLayoutManager()
    
    public var cardLayoutView: CardLayoutView?
    var cardLayoutViewDataSource = CardViewDataSource()
    var cardLayoutViewDelegate = CardViewDelegate()
    
    var cardCollectionViewLayout: CardCollectionViewLayout?
    
    public var shadowRadius: CGFloat = 5.0
    public var shadowOpacity: CGFloat = 1.0
    public var shadowHeight: CGFloat = 2.0
    public var shadowColor: CGColor = UIColor.lightGray.cgColor
    public var animationDuration: TimeInterval = 0.40
    public var frame: CGRect = .zero
    
    public var contentControllers: [UIViewController] = [] {
        didSet {
            cardLayoutView?.reloadData()
        }
    }
    
    private override init() {
        // Singleton instance
    }
    
    public func setup() {
        cardCollectionViewLayout = CardCollectionViewLayout()
        cardLayoutView = CardLayoutView(frame: frame, collectionViewLayout: cardCollectionViewLayout!)
        
        cardLayoutView?.delegate = self
        cardLayoutView?.dataSource = self
        
        
        // Register the cell
        cardLayoutView?.register(UINib(nibName: "CardCollectionViewCell", bundle: nil),  forCellWithReuseIdentifier: "cardCell")
        
    }
    
    func reloadCards() {
        cardLayoutView?.reloadData()
    }
}

extension CardLayoutManager: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentControllers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
        cell.contentViewController = contentControllers[indexPath.item]
        contentControllers[indexPath.item].view.frame = cell.contentView.bounds
        cell.populateCell()
        
        return cell
    }
}

extension CardLayoutManager: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cardView = collectionView as? CardLayoutView else { return }
        cardView.openCardAtIndexPath(indexPath, in: cardView)
    }
}
