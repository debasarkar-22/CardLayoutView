//
//  CardViewDelegate.swift
//  CardLayoutView
//
//  Created by Debaditya  Sarkar on 11/27/17.
//  Copyright © 2017 Debaditya. All rights reserved.
//

import Foundation
class CardViewDelegate: NSObject, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cardView = collectionView as? CardLayoutView else { return }
        cardView.openCardAtIndexPath(indexPath, in: cardView)
    }
}
