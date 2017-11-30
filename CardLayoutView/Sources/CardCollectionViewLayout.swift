//
//  CardCollectionViewLayout.swift
//  CardLayoutView
//
//  Created by Debaditya  Sarkar on 11/28/17.
//  Copyright © 2017 Debaditya. All rights reserved.
//

import UIKit
protocol CardStateDelegate: class {
    func indexPathForOpenCard( in collectionView: UICollectionView) -> IndexPath?
}

class CardCollectionViewLayout: UICollectionViewLayout {
    
    private var cardLayoutAttributes: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0.0
    private var collectionViewWidth: CGFloat {
        guard let collectionView = collectionView else { return 0.0 }
        return collectionView.bounds.width
    }
    
    weak var delegate: CardStateDelegate?
    
    var xOffSet: CGFloat = 0
    
    var openCardHeight: CGFloat {
        set {
            
        }
        get {
            if CommonUtils.isIphoneX() {
                return 595
            } else {
                switch UIScreen.main.bounds.width {
                case 320:
                    if CommonUtils.isZoomedMode() {
                        return 460 // Fix for Zoomed Mode (144428)
                    }
                    return 470
                case 375.0:
                    return 542
                default:
                    return 580
                }
            }
        }
    }
    var closedCardHeight: CGFloat = 51
    var cardWidth: CGFloat = 275
    var topPadding: CGFloat = 12
    var bottomPadding: CGFloat {
        set {
            
        }
        get {
            if CommonUtils.isIphoneX() {
                return 30
            } else {
                switch UIScreen.main.bounds.width {
                case 320:
                    if CommonUtils.isZoomedMode() {
                        return 10.0 // Fix for Zoomed Mode (144428)
                    }
                    return 8.0
                case 375.0:
                    return 16.0
                default:
                    return 16.0 // Defect 145114 Fix
                }
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionViewWidth, height: contentHeight)
    }
    
    override func prepare() {
        super.prepare()
        cardLayoutAttributes.removeAll()
        if let collectionView = collectionView {
            if let openIndexPath = delegate?.indexPathForOpenCard(in: collectionView) {
                prepareForOpenCard(at: openIndexPath)
            } else {
                prepareForNormalMode()
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes: [UICollectionViewLayoutAttributes] = []
        for cardLayoutAttribute in cardLayoutAttributes {
            if cardLayoutAttribute.frame.intersects(rect) {
                layoutAttributes.append(cardLayoutAttribute)
            }
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        var layoutAttributes: UICollectionViewLayoutAttributes?
        for layoutAttribute in cardLayoutAttributes {
            if layoutAttribute.indexPath == indexPath {
                layoutAttributes = layoutAttribute
            }
        }
        return layoutAttributes
    }
    
    func prepareForOpenCard(at: IndexPath) {
        if let collectionView = collectionView {
            let numberOfCards = collectionView.numberOfItems(inSection: 0)
            
            var yOffSet = topPadding + openCardHeight + bottomPadding
            if CommonUtils.isIphoneX() {
                yOffSet += 10
            }
            let collectionViewHeight: CGFloat = collectionView.bounds.height
            let closedCardsHeight: CGFloat = collectionViewHeight - yOffSet
            contentHeight = collectionView.bounds.height // Content Height for open state will be equal to collection view height
            
            for card in 0..<numberOfCards {
                let indexPath = IndexPath(item: card, section: 0)
                if indexPath == at {
                    let cardHeight = openCardHeight
                    let frame = CGRect(x: xOffSet, y: topPadding, width: collectionViewWidth, height: cardHeight)
                    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    attributes.frame = frame
                    attributes.zIndex = card // Reload Issue Fix
                    cardLayoutAttributes.append(attributes)
                } else {
                    let numberOfVisibleCards = numberOfCards > 5 ? 5 : numberOfCards
                    let cardHeight = closedCardsHeight / (CGFloat(numberOfVisibleCards - 1))
                    let frame = CGRect(x: xOffSet, y: yOffSet, width: collectionViewWidth, height: openCardHeight)
                    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    attributes.frame = frame
                    attributes.zIndex = card // Reload Issue Fix
                    cardLayoutAttributes.append(attributes)
                    yOffSet += cardHeight
                }
            }
        }
    }
    
    func prepareForNormalMode() {
        if let collectionView = collectionView {
            let numberOfCards = collectionView.numberOfItems(inSection: 0)
            var yOffSet = topPadding
            contentHeight = topPadding + 20
            for card in 0..<numberOfCards {
                let indexPath = IndexPath(item: card, section: 0)
                let cardHeight = card == (numberOfCards - 1) ? openCardHeight : closedCardHeight
                let frame = CGRect(x: xOffSet, y: yOffSet, width: collectionViewWidth, height: openCardHeight)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                attributes.zIndex = card // Reload Issue Fix
                cardLayoutAttributes.append(attributes)
                contentHeight += cardHeight
                yOffSet += cardHeight
            }
        }
    }
    
}
