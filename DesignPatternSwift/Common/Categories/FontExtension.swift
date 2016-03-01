//
//  FontExtension.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 01/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import Foundation
import UIKit


extension UIFont{
    
    class func helvaticaLight45WithSize(inSize : CGFloat) -> UIFont
    {
        return UIFont(name: "HelveticaNeueLTStd-Lt", size: inSize)!
    }
    
    class func helvaticaRoman55WithSize(inSize : CGFloat) -> UIFont
    {
        return UIFont(name: "HelveticaNeueLTStd-Roman", size: inSize)!
    }
}