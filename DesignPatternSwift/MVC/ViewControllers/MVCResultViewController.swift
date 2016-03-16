//
//  MVCResultViewController.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 07/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MVCResultViewController: GKBSuperViewController {
    
    var questionsArray : NSArray?

    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setResult()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Methods
    
    func setResult()
    {
        var correctAnswer = 0
        
        guard let questionsArrayTemp = self.questionsArray
            else{return}
        
        for(var index  = 0; index < questionsArrayTemp.count ; index++ )
        {
            let question : GKBQuestion = questionsArrayTemp[index] as! GKBQuestion
            var userAnswerAppended = NSString(string: question.userAnswer)
            if userAnswerAppended.length > 3
            {
                userAnswerAppended = userAnswerAppended.stringByReplacingCharactersInRange(NSMakeRange(0, 3), withString: "")
                let isAnswerCorrect = question.correctAnswer == userAnswerAppended ? true : false
                if isAnswerCorrect{
                    correctAnswer++
                }
            }
        }
        
        self.resultLabel.text = String(format: "%d/%d", arguments: [correctAnswer,questionsArrayTemp.count])
    }
    
    // MARK: - Action Methods
    
    @IBAction func showAnswerButtonTapped(sender: AnyObject) {
        let viewController : MVCAllAnswersViewController = UIStoryboard.gameMVCStoryBoard().instantiateViewControllerWithIdentifier("CDAllAnswersVC") as! MVCAllAnswersViewController
        viewController.questionsArray = self.questionsArray
        GKBConstants.BASE_VIEWCONTROLLER.pushViewController(viewController, withAnimation: true)
    }
    

}
