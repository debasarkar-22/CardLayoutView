//
//  CommonUtils.swift
//  CardLayoutView
//
//  Created by Debaditya  Sarkar on 11/28/17.
//  Copyright © 2017 Debaditya. All rights reserved.
//

import Foundation
class CommonUtils {
    static func isZoomedMode() -> Bool {
        return false
    }
    
    static func isIphoneX() -> Bool {
        return UIDevice().userInterfaceIdiom == .phone ? (UIScreen.main.nativeBounds.height == 2436 ? true : false) : false
    }
}
