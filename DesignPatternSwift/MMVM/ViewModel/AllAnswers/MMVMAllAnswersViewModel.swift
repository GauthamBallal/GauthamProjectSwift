//
//  MMVMAllAnswersViewModel.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 16/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MMVMAllAnswersViewModel: MMVMAllAnswersInterface {

    var questionsArray : NSArray = []

    func numberOfRows() -> NSInteger
    {
        return self.questionsArray.count
    }
    func getQuestionTextForRow(row :NSInteger) -> NSString
    {
        let question:GKBQuestion = questionsArray[row] as! GKBQuestion
        return question.question!
    }
    func getAnswerTextForRow(row :NSInteger) -> NSString
    {
        let question:GKBQuestion = questionsArray[row] as! GKBQuestion
        return question.correctAnswer!
    }
    func getUserAnswerTextForRow(row :NSInteger) -> NSString
    {
        let question:GKBQuestion = questionsArray[row] as! GKBQuestion
        return question.userAnswer
    }
    
    func goToMainMenuTapped()
    {
        GKBConstants.BASE_VIEWCONTROLLER.popViewRootViewControllerAnimated(true);
    }
    
}
