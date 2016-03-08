//
//  MVCAllAnswersViewController.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 07/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MVCAllAnswersViewController: GKBSuperViewController {

    var questionsArray : NSArray?
    @IBOutlet weak var allAnswersTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.allAnswersTableView.reloadData()
    }
    
    // MARK: - Private Method

    func heightForIndexPath(indexPath:NSIndexPath) -> CGFloat
    {
        let question : GKBQuestion = questionsArray![indexPath.row] as! GKBQuestion
        let questionHeight :CGFloat = (question.question!.heightWithConstrainedWidth(280.0, font: UIFont.helvaticaRoman55WithSize(13.0)))
        let answerHeight :CGFloat = (question.correctAnswer!.heightWithConstrainedWidth(280.0, font: UIFont.helvaticaLight45WithSize(13.0)))
        
        return questionHeight + answerHeight + 85;
    }

    // MARK: -  TableViewDelegate
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.questionsArray!.count
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let question : GKBQuestion = questionsArray![indexPath.row] as! GKBQuestion
        let cell : GKBAllAnswersTableViewCell = tableView.dequeueReusableCellWithIdentifier("AllAnswersCell") as! GKBAllAnswersTableViewCell
        cell.constructCellWithQuestion(question);
        cell.questionsLabel.text = NSString(format: "%d. %@",indexPath.row + 1,question.question!) as String;

        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let cellheight = heightForIndexPath(indexPath)
        return cellheight
    }
    
    
    // MARK: - Action Method
    @IBAction func goToMainButtonTapped(sender: AnyObject) {
        GKBConstants.BASE_VIEWCONTROLLER.popViewRootViewControllerAnimated(true);
    }
    
}
