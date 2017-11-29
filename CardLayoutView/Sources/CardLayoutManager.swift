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
    
    public var contentControllers: [UIViewController] = [] {
        didSet {
            cardLayoutViewDataSource.viewControllers = contentControllers
            cardLayoutView?.reloadData()
        }
    }
    
    private override init() {
        // Singleton instance
    }
    
    public func setup() {
        cardLayoutView?.delegate = cardLayoutViewDelegate
        cardLayoutView?.dataSource = cardLayoutViewDataSource
        
        cardLayoutViewDataSource.shadowRadius = shadowRadius
        cardLayoutViewDataSource.shadowOpacity = shadowOpacity
        cardLayoutViewDataSource.shadowHeight = shadowHeight
        cardLayoutViewDataSource.shadowColor = shadowColor
        cardLayoutViewDataSource.viewControllers = contentControllers
        
        cardCollectionViewLayout = cardLayoutView?.collectionViewLayout as? CardCollectionViewLayout
        
        // Register the cell
        cardLayoutView?.register(UINib(nibName: "CardCollectionViewCell", bundle: nil),  forCellWithReuseIdentifier: "cardCell")
        
    }
    
    func reloadCards() {
        cardLayoutView?.reloadData()
    }
}
