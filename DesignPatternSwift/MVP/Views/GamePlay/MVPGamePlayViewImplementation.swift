//
//  MVPGamePlayViewImplementation.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 21/04/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MVPGamePlayViewImplementation: GKBSuperViewController,MVPGamePlayView {

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
    @IBOutlet weak var errorLabel: UILabel!
    
    var presenter:MVPGamePlayPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("hintTapped:"), name: GKBConstants.kHintNotification, object: nil)
        self.questionLabel.numberOfLines = 0;
        self.presenter = MVPGamePlayPresenter(view: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let navBar : GKBNavigationBar = self.navigationController?.navigationBar.viewWithTag(GKBConstants.kCustomNavigationBarTag) as! GKBNavigationBar
        navBar.shouldHideBackButton(true);
        navBar.shouldHideHintButton(false)
        self.presenter.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -  MVPPackageListingView
    
    func loadDataToView()
    {
        loadViewWithQuestion()
    }
    
    func noDataAvailable()
    {
        self.errorLabel.hidden = false
    }
    
    func setTimerText(timeToSet:String)
    {
        if timeToSet.characters.count > 0{
            self.timerButton.setTitle(timeToSet, forState: .Normal)
        } else {
            self.timerButton.setTitle("", forState: .Normal)
        }
    }
    
    // MARK: - Private Methods
    
    func loadViewWithQuestion()
    {
        let question:GKBQuestion = self.presenter.itemAtIndex(0) as! GKBQuestion
        tableView.alpha = 0.1;
        let questionText = String(format: "Q %d.%@",self.presenter.getQuestionNumber()+1,question.question!)
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
    
    func optionForRow(row : Int) -> String
    {
        var option:String?
        let question:GKBQuestion = self.presenter.itemAtIndex(0) as! GKBQuestion;
        
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
    
    // MARK: -  TableViewDelegate
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.presenter.totalItems()
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
        self.presenter.cellTappedAtIndex(indexPath.row)
        nextButtonPressed(String())
    }
    

    // MARK: - Action Methods
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        self.presenter.submitButtonTapped()
    }
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        self.presenter.nextButtonTapped()
        if self.presenter.shouldLoadNextQuestion() {
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
            let question:GKBQuestion = self.presenter.itemAtIndex(0) as! GKBQuestion;
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

}
