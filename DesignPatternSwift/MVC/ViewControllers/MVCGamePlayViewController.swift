//
//  MVCGamePlayViewController.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 01/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MVCGamePlayViewController: UIViewController {
    
    @IBOutlet weak var  timerButton : UIButton!
    @IBOutlet weak var  packageNameButton : UIButton!
    @IBOutlet weak var  questionView : UIView!
    @IBOutlet weak var  questionLabel:UILabel!
    @IBOutlet weak var  testTextView:UITextView!
    @IBOutlet weak var  tableView:UITableView!
    @IBOutlet weak var  hintHolderView:UIView!
    @IBOutlet weak var  hintView:UIView!
    @IBOutlet weak var  hintPopUpImageView:UIImageView!
    @IBOutlet weak var  hintLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Action Methods
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func hintGotItButtonPressed(sender: AnyObject) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.hintHolderView.alpha = 0.0;
            },completion: { (completion : Bool) -> Void in
                self.hintHolderView.superview?.sendSubviewToBack(self.hintHolderView);
        })
        
//        UIView.animateWithDuration(0.5, animations: { () -> Void in
//            self.hintHolderView.alpha = 0.0;
//            }) { (completion : Bool) -> Void in
//                if(completion){
//                    self.hintHolderView.superview?.sendSubviewToBack(self.hintHolderView);
//                }
//        }
    }


}
