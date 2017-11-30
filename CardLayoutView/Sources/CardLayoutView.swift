//
//  CardLayoutView.swift
//  CardLayoutView
//
//  Created by Debaditya  Sarkar on 11/27/17.
//  Copyright © 2017 Debaditya. All rights reserved.
//

import UIKit

public class CardLayoutView: UICollectionView, CardStateDelegate {
    
    var cardLayoutManager: CardLayoutManager?
    var indexPathForOpenCard: IndexPath?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        (collectionViewLayout as? CardCollectionViewLayout)?.delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func indexPathForOpenCard(in collectionView: UICollectionView) -> IndexPath? {
        return indexPathForOpenCard
    }
    
    func setupUI() {
        backgroundColor = .lightGray
    }
    
    func openCardAtIndexPath(_ indexPath: IndexPath, in collectionView: UICollectionView) {
        indexPathForOpenCard = indexPathForOpenCard != nil ? nil : indexPath
        
        UIView.animate(withDuration: cardLayoutManager?.animationDuration ?? 0.40) {
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
}
