//
//  MMVMAllAnswersViewController.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 16/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MMVMAllAnswersViewController: GKBSuperViewController {
    
    @IBOutlet weak var allAnswersTableView: UITableView!
    var viewModel:MMVMAllAnswersViewModel = MMVMAllAnswersViewModel()

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
        let questionHeight :CGFloat = ((viewModel.getQuestionTextForRow(indexPath.row) as String).heightWithConstrainedWidth(280.0, font: UIFont.helvaticaRoman55WithSize(13.0)))
        let answerHeight :CGFloat = ((viewModel.getAnswerTextForRow(indexPath.row) as String).heightWithConstrainedWidth(280.0, font: UIFont.helvaticaLight45WithSize(13.0)))
        
        return questionHeight + answerHeight + 85;
    }
    
    // MARK: -  TableViewDelegate
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.viewModel.numberOfRows()
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell : MMVMAllAnswersTableViewCell = tableView.dequeueReusableCellWithIdentifier("AllAnswersCell") as! MMVMAllAnswersTableViewCell
        
        let question : String = self.viewModel.getQuestionTextForRow(indexPath.row) as String
        let answer : String = self.viewModel.getAnswerTextForRow(indexPath.row) as String
        let userAnswer : String = self.viewModel.getUserAnswerTextForRow(indexPath.row) as String
        let questionHeight :CGFloat = (question.heightWithConstrainedWidth(280.0, font: UIFont.helvaticaRoman55WithSize(13.0)))
        let answerHeight :CGFloat = (answer.heightWithConstrainedWidth(280.0, font: UIFont.helvaticaLight45WithSize(13.0)))
        
        cell.questionLabel.setHeight(questionHeight)
        cell.answerButton.setY(cell.questionLabel.frame.origin.y + questionHeight + 20)
        cell.answerButton.setHeight(answerHeight+30)
        cell.questionLabel.text = question;

        
        if userAnswer.characters.count > 0
        {
            var userAnswerAppender : NSString = NSString(string: userAnswer)
            userAnswerAppender = userAnswerAppender.stringByReplacingCharactersInRange(NSMakeRange(0, 3), withString: "")
            let correctAnswer = userAnswerAppender == answer ? true : false
            cell.setBackgroundForState(correctAnswer)
            
            cell.answerButton.setAttributedTitle(NSAttributedString(string: answer), forState: .Normal)
        }
        else
        {
            cell.setBackgroundForState(false)
            cell.answerButton.setAttributedTitle(NSAttributedString(string: "Not Answered"), forState: .Normal)
        }
        
        cell.backgroundImageView.setY(10)
        cell.backgroundImageView.setHeight(questionHeight+answerHeight+75)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let cellheight = heightForIndexPath(indexPath)
        return cellheight
    }
    
    
    // MARK: - Action Method
    @IBAction func goToMainButtonTapped(sender: AnyObject) {
        self.viewModel.goToMainMenuTapped()
    }


}
