//
//  MMVMGamePlayViewController.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 15/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MMVMGamePlayViewController: GKBSuperViewController {

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
    
    var updateTimeCallback:GKBConstants.MMVMTimerCallack?

    var viewModel:MMVMGamePlayViewModel = MMVMGamePlayViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("hintTapped:"), name: GKBConstants.kHintNotification, object: nil)
        // Do any additional setup after loading the view.
        self.questionLabel.numberOfLines = 0;
        
        loadViewWithQuestion()
        
        self.viewModel.setInitialTime({ (timeToSet) -> (Void) in
            self.setTimerText(timeToSet)
        })
        
        self.updateTimeCallback = { (timeToSet) -> (Void) in
            self.setTimerText(timeToSet)
        }
        
        self.viewModel.timerCallback = self.updateTimeCallback;
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let navBar : GKBNavigationBar = self.navigationController?.navigationBar.viewWithTag(GKBConstants.kCustomNavigationBarTag) as! GKBNavigationBar
        navBar.shouldHideBackButton(true);
        navBar.shouldHideHintButton(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Methods
    
    func setTimerText(timeToSet:NSString?)
    {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if let time = timeToSet
            {
                guard let timerButtonLet = self.timerButton
                    else {return}
                timerButtonLet.setTitle(time as String, forState: .Normal)
            }
            else {
                self.submitButtonPressed(String())
            }
            
            
        }
    }
    
    func loadViewWithQuestion()
    {
        tableView.alpha = 0.1;
        let questionText = String(format: "Q %d.%@",self.viewModel.getQuestionNumber()+1,self.viewModel.getQuestionText())
        let height = questionText.heightWithConstrainedWidth(self.questionLabel.frame.size.width, font: self.questionLabel.font)
        self.questionView.setHeight(height+30)
        self.questionLabel.setHeight(height)
        self.questionLabel.text = questionText
        
        tableView.tableHeaderView = self.questionView;
        tableView.reloadData()
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.tableView.alpha = 1.0;
        }
    }
    
    func heightForText(optionsText:String) -> CGFloat
    {
        var height : CGFloat
        height = optionsText.heightWithConstrainedWidth(self.tableView.frame.size.width - 30.0, font: UIFont.helvaticaLight45WithSize(13.0)) + 2
        return height
    }
    

    // MARK: -  TableViewDelegate
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.viewModel.numberOfRows()
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell : GKBOptionsTableViewCell = tableView.dequeueReusableCellWithIdentifier("OptionsCell") as! GKBOptionsTableViewCell
        let optionText:String = self.viewModel.optionForRow(indexPath.row) as String
        cell.setOptionsText(optionText)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let optionText:String = self.viewModel.optionForRow(indexPath.row) as String
        let cellheight = heightForText(optionText) + 45
        return cellheight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.viewModel.selectedAnswerAtIndexPath(indexPath)
        nextButtonPressed(String())
    }
    
    // MARK: - Action Methods
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
        self.viewModel.timerCallback = nil
        self.viewModel.submitButtonTapped()
    }
    
    @IBAction func nextButtonPressed(sender: AnyObject) {

        self.viewModel.nextButtonTapped()
        if(self.viewModel.shouldLoadNextQuestion())
        {
            loadViewWithQuestion()
        }
    }
    
    @IBAction func hintGotItButtonPressed(sender: AnyObject) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.hintHolderView.alpha = 0.0;
            },completion: { (completion : Bool) -> Void in
                self.hintHolderView.superview?.sendSubviewToBack(self.hintHolderView);
        })
        
        NSNotificationCenter.defaultCenter().postNotificationName(GKBConstants.kHintNotification, object: nil, userInfo:["selected":NSNumber(bool: false)])
    }
    
    // MARK: - Notifications
    func hintTapped(hintNotification:NSNotification)
    {
        let hintTapped : NSNumber = (hintNotification.userInfo?["selected"])! as! NSNumber
        
        if(hintTapped == 1)
        {
            let heightForLabel = (self.viewModel.getHint() as String).heightWithConstrainedWidth(self.hintLabel.frame.size.width, font: self.hintLabel.font)
            var heightForView = heightForLabel + 86.0;
            heightForView = heightForView < 128.0 ? 128.0 : heightForView;
            self.hintView.setHeight(heightForView)
            self.hintLabel.setHeight(heightForLabel)
            
            let editedImage = self.hintPopUpImageView.image?.resizableImageWithCapInsets(UIEdgeInsetsMake(50.0, 10.0, 20.0, 10.0))
            self.hintPopUpImageView.image = editedImage
            self.hintView.center = self.hintHolderView.center
            
            self.hintLabel.text = (self.viewModel.getHint() as String)
            
            self.hintHolderView.superview?.bringSubviewToFront(self.hintHolderView);
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.hintHolderView.alpha = 1.0;
                },completion: { (completion : Bool) -> Void in
            })
        }
        else
        {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.hintHolderView.alpha = 0.0;
                },completion: { (completion : Bool) -> Void in
                    self.hintHolderView.superview?.sendSubviewToBack(self.hintHolderView);
            })
        }
        
    }


}
