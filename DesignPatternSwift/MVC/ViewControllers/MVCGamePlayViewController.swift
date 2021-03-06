//
//  MVCGamePlayViewController.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 01/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MVCGamePlayViewController: GKBSuperViewController {
    
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
    
    var test : GKBTest?

    
    var currentTime:Double = 0.0
    var userSelectedAnswer : NSString = ""
    var timer:NSTimer = NSTimer()
    var questionsArray:NSMutableArray = NSMutableArray()
    var currentQuestion:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("hintTapped:"), name: GKBConstants.kHintNotification, object: nil)
        
        self.timerButton.setTitle(getTimeForSeconds(GKBConstants.kTotalGameTime), forState: .Normal)

        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("timerChanged"), userInfo: nil, repeats: true)
        self.currentQuestion = 0;


        for question in self.test!.questions! {
            self.questionsArray.addObject(question)
        }
        
//        self.packageNameButton .setTitle((self.questionsArray.lastObject! as! GKBQuestion).testName, forState: .Normal)

        self.questionLabel.numberOfLines = 0;
        loadViewWithQuestion()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let navBar : GKBNavigationBar = self.navigationController?.navigationBar.viewWithTag(GKBConstants.kCustomNavigationBarTag) as! GKBNavigationBar
        navBar.shouldHideBackButton(true);
        navBar.shouldHideHintButton(false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Methods
    
    func loadViewWithQuestion()
    {
        let question:GKBQuestion = questionsArray[self.currentQuestion] as! GKBQuestion
        tableView.alpha = 0.1;
        let questionText = String(format: "Q %d.%@",self.currentQuestion+1,question.question!)
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
    
    func getTimeForSeconds(time:Double) -> String
    {
        let minute = floor(time/60)
        let seconds = time - (60*minute)
        return String(format: "%@:%@", minute < 10.0 ? String(format: "0%.0f", minute) : String(format: "%.0f", minute),seconds < 10.0 ? String(format: "0%.0f", seconds) : String(format: "%.0f", seconds));
    }
    
    @objc
    func timerChanged()
    {
        self.currentTime++
        let timeLeft = (GKBConstants.kTotalGameTime - self.currentTime)
        self.timerButton.setTitle(getTimeForSeconds(timeLeft), forState: .Normal)
    }
    
    func optionForRow(row : Int) -> String
    {
        var option:String?
        let question:GKBQuestion = questionsArray[self.currentQuestion] as! GKBQuestion;

        switch(row)
        {
        case 0:
            option = question.optionOne!
            break
        case 1:
            option = question.optionTwo!
            break
        case 2:
            option = question.optionThree!
            break
        default:
            option = question.optionFour!
            break
        }
        
        return option!
    }
    
    func heightForText(optionsText:String) -> CGFloat
    {
        var height : CGFloat
        height = optionsText.heightWithConstrainedWidth(self.tableView.frame.size.width - 30.0, font: UIFont.helvaticaLight45WithSize(13.0)) + 2
        return height
    }
    

    // MARK: - Action Methods
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
        if self.timer.valid == true
        {
            self.timer.invalidate()
        }
        
        let viewController : MVCResultViewController = UIStoryboard.gameMVCStoryBoard().instantiateViewControllerWithIdentifier("CDResultChartVC") as! MVCResultViewController
        
        viewController.questionsArray = self.questionsArray
        GKBConstants.BASE_VIEWCONTROLLER.pushViewController(viewController, withAnimation: true)
    }
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        ((questionsArray[self.currentQuestion]) as! GKBQuestion).userAnswer = self.userSelectedAnswer as String;

        if(self.questionsArray.count > (self.currentQuestion+1))
        {
            self.currentQuestion++
            self.userSelectedAnswer = ""
            loadViewWithQuestion()
        }
        else
        {
            submitButtonPressed(String())
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
            let question:GKBQuestion = questionsArray[self.currentQuestion] as! GKBQuestion;
            let heightForLabel = question.hint?.heightWithConstrainedWidth(self.hintLabel.frame.size.width, font: self.hintLabel.font)
            var heightForView = heightForLabel! + 86.0;
            heightForView = heightForView < 128.0 ? 128.0 : heightForView;
            self.hintView.setHeight(heightForView)
            self.hintLabel.setHeight(heightForLabel!)
            
            let editedImage = self.hintPopUpImageView.image?.resizableImageWithCapInsets(UIEdgeInsetsMake(50.0, 10.0, 20.0, 10.0))
            self.hintPopUpImageView.image = editedImage
            self.hintView.center = self.hintHolderView.center

            self.hintLabel.text = question.hint;

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
    
    // MARK: -  TableViewDelegate
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.questionsArray.count > 0 ? 4 : 0
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell : GKBOptionsTableViewCell = tableView.dequeueReusableCellWithIdentifier("OptionsCell") as! GKBOptionsTableViewCell
        cell.setOptionsText(optionForRow(indexPath.row));
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let cellheight = heightForText(optionForRow(indexPath.row)) + 45
        return cellheight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.userSelectedAnswer = optionForRow(indexPath.row)
        nextButtonPressed(String())
    }
    


}
