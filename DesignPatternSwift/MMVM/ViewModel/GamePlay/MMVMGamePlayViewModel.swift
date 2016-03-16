//
//  MMVMGamePlayViewModel.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 15/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import Foundation
import UIKit

class MMVMGamePlayViewModel : MMVMGamePlayInterface {
    
    var timerCallback:GKBConstants.MMVMTimerCallack?
    var currentTime:Double = 0.0
    var userSelectedAnswer : NSString = ""
    var timer:NSTimer = NSTimer()
    var questionsArray:NSMutableArray = NSMutableArray()
    var currentQuestion:Int = 0
    
    var test : GKBTest? {
        didSet{
            for question in self.test!.questions! {
                self.questionsArray.addObject(question)
            }
        }
    }
    
    init() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("timerChanged"), userInfo: nil, repeats: true)
        self.currentQuestion = 0;
    }
    
    func numberOfRows() -> NSInteger
    {
        return 4
    }
    
    func optionForRow(row :NSInteger) -> NSString
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
    
    func getQuestionText() -> NSString
    {
        let question:GKBQuestion = questionsArray[self.currentQuestion] as! GKBQuestion;
        return question.question!;
    }
    
    func getHint() -> NSString
    {
        let question:GKBQuestion = questionsArray[self.currentQuestion] as! GKBQuestion;
        return question.hint!;
    }
    
    func getQuestionNumber() -> NSInteger
    {
        return self.currentQuestion
    }
    
    func setInitialTime(callback : GKBConstants.MMVMTimerCallack)
    {
        callback(timeToSet: getTimeForSeconds(GKBConstants.kTotalGameTime))
    }
    
    func selectedAnswerAtIndexPath(indexPath : NSIndexPath)
    {
        self.userSelectedAnswer = optionForRow(indexPath.row)
    }
    
    func shouldLoadNextQuestion() -> Bool
    {
        return !(self.questionsArray.count == self.currentQuestion);
    }
    
    func nextButtonTapped()
    {
        ((questionsArray[self.currentQuestion]) as! GKBQuestion).userAnswer = self.userSelectedAnswer as String;
        
        if(self.questionsArray.count > (self.currentQuestion+1))
        {
            self.currentQuestion++
            self.userSelectedAnswer = ""
        }
        else
        {
            submitButtonTapped()
        }
    }
    
    func submitButtonTapped()
    {
        if self.timer.valid == true
        {
            self.timer.invalidate()
        }
        let viewController : MMVMResultViewController = UIStoryboard.gameMMVMStoryBoard().instantiateViewControllerWithIdentifier("CDResultChartVC") as! MMVMResultViewController
        
        viewController.viewModel.answers = self.questionsArray
        GKBConstants.BASE_VIEWCONTROLLER.pushViewController(viewController, withAnimation: true)
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
        if let timercallbacktemp = self.timerCallback
        {
            let timeLeft = (GKBConstants.kTotalGameTime - self.currentTime)
            timercallbacktemp(timeToSet: getTimeForSeconds(timeLeft))
        }
    }
}