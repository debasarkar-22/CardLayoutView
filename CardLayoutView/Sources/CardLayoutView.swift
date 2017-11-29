//
//  CardLayoutView.swift
//  CardLayoutView
//
//  Created by Debaditya  Sarkar on 11/27/17.
//  Copyright © 2017 Debaditya. All rights reserved.
//

import UIKit

public class CardLayoutView: UICollectionView {
    
    var cardViewDelegate: CardViewDelegate?
    var cardViewDataSource: CardViewDataSource?
    
    var contentControllers: [UIViewController] = []
    
    var shadowRadius: CGFloat = 5.0
    var shadowOpacity: CGFloat = 1.0
    var shadowHeight: CGFloat = 2.0
    var shadowColor: CGColor = UIColor.lightGray.cgColor
    
    var indexPathForOpenCard: IndexPath?
    
    var animationDuration: TimeInterval = 0.40
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        setupUI()
        setupCollectionView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        cardViewDelegate = CardViewDelegate()
        cardViewDataSource = CardViewDataSource()
        
        cardViewDataSource?.shadowRadius = shadowRadius
        cardViewDataSource?.shadowOpacity = shadowOpacity
        cardViewDataSource?.shadowHeight = shadowHeight
        cardViewDataSource?.shadowColor = shadowColor
        cardViewDataSource?.viewControllers = contentControllers
        
        // Register the cell
        register(UINib(nibName: "CardCollectionViewCell", bundle: nil),  forCellWithReuseIdentifier: "cardCell")
        
        delegate = cardViewDelegate
        dataSource = cardViewDataSource
    }
    
    func setupUI() {
        backgroundColor = .lightGray
    }
    
    func openCardAtIndexPath(_ indexPath: IndexPath, in collectionView: UICollectionView) {
        indexPathForOpenCard = indexPathForOpenCard != nil ? nil : indexPath
        
        UIView.animate(withDuration: animationDuration) {
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
}
