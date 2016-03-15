//
//  StoryboardExtension.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 29/02/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard
{
    class func gameMVCStoryBoard() -> UIStoryboard
    {
        return UIStoryboard(name: "MVCStoryboard", bundle: nil)
    }
    
    class func gameMMVMStoryBoard() -> UIStoryboard
    {
        return UIStoryboard(name: "MMVMStoryboard", bundle: nil)
    }
    
}