//
//  MMVMResultViewModel.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 16/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MMVMResultViewModel: MMVMResultInterface {

    var answers:NSMutableArray?
    
    func getResultText() -> NSString
    {
        var correctAnswer = 0
    
        if let questionsArrayTemp = self.answers
        {
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
        }
        
        return String(format: "%d/%d", arguments: [correctAnswer,self.answers!.count])
    }
    
    func showAllAnswerButonTapped()
    {
        let viewController : MVCAllAnswersViewController = UIStoryboard.gameMVCStoryBoard().instantiateViewControllerWithIdentifier("CDAllAnswersVC") as! MVCAllAnswersViewController
        viewController.questionsArray = self.answers
        GKBConstants.BASE_VIEWCONTROLLER.pushViewController(viewController, withAnimation: true)
    }
}
