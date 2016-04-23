//
//  MVPResultsPresenter.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 21/04/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MVPResultsPresenter: MVPBasePresenter {
    var answers:NSArray?

    var view:MVPResultView
    var interactor:MVPResultsInteractor
    
    required init(view:MVPResultView)
    {
        self.view = view
        self.interactor = MVPInteractor.sharedInstance
        super.init()
    }
    
    override func loadData() {
        self.answers = self.interactor.getAllQuestions()
        if self.answers?.count > 0 {
            self.view.loadDataToView()
        }
    }
 
    func getResultText() -> String
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
        let viewController : MVPAllAnswersViewImplementation = UIStoryboard.gameMVPStoryBoard().instantiateViewControllerWithIdentifier("CDAllAnswersVC") as! MVPAllAnswersViewImplementation
        GKBConstants.BASE_VIEWCONTROLLER.pushViewController(viewController, withAnimation: true)
    }
    
}
