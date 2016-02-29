//
//  GKBNavigationBar.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 29/02/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class GKBNavigationBar: UIView {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var hintButton: UIButton!

    @IBAction func hintButtonTapped(sender: AnyObject) {
    }
    @IBAction func backButtonTapped(sender: AnyObject) {
        GKBConstants.BASE_VIEWCONTROLLER.popViewControllerAnimated(true);
    }
    
    @IBAction func settingButtonTapped(sender: AnyObject) {
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func shouldHideBackButton(shouldHide : Bool) -> Void{
        backButton.hidden = shouldHide;
    }
    
    func shouldHideHintButton(shouldHide : Bool) -> Void{
        hintButton.hidden = shouldHide;
    }
    
    func enableNavUserInteraction()
    {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.overlayView.alpha = self.hintButton.selected ? 0.0 : 1.0;
            }, completion: nil);
        hintButton.selected = !hintButton.selected;
    }

}
