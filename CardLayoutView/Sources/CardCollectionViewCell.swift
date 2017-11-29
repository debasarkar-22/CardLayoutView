//
//  CardCollectionViewCell.swift
//  CardLayoutView
//
//  Created by Debaditya  Sarkar on 11/29/17.
//  Copyright © 2017 Debaditya. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    var contentViewController: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateCell() {
        if let contentViewController = contentViewController {
            self.contentView.addSubview(contentViewController.view)
        }
    }
}
