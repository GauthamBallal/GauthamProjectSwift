//
//  FrameExtension.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 01/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func setX(inX:CGFloat)
    {
        var frame = self.frame;
        frame.origin.x = inX;
        self.frame = frame;
    }
    
    func setY(inY : CGFloat)
    {
        var frame = self.frame;
        frame.origin.y = inY;
        self.frame = frame;
    }
    
    func setWidth(inWidth : CGFloat)
    {
        var frame = self.frame;
        frame.size.width = inWidth;
        self.frame = frame;
    }
    
    func setHeight(inHeight:CGFloat)
    {
        var frame = self.frame;
        frame.size.height = inHeight;
        self.frame = frame;
    }
    
    func setSize(inSize:CGSize)
    {
        var frame = self.frame;
        frame.size = inSize;
        self.frame = frame;
    }
    
    func setOrigin(inOrigin:CGPoint)
    {
        var frame = self.frame;
        frame.origin = inOrigin;
        self.frame = frame;
    }

}
