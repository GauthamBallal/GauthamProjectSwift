//
//  MVPGamePlayPresenter.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 21/04/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MVPGamePlayPresenter: MVPBasePresenter {

    var view:MVPGamePlayView
    var interactor:MVPGamePlayInteractor
    
    
    var currentTime:Double = 0.0
    var userSelectedAnswer:NSString = ""
    var timer:NSTimer = NSTimer()
    var questionsArray:NSArray = []
    var currentQuestion:Int = 0
    
    required init(view:MVPGamePlayView)
    {
        self.view = view
        self.interactor = MVPInteractor.sharedInstance

        super.init()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("timerChanged"), userInfo: nil, repeats: true)
    }
    
    override func loadData() {
        self.questionsArray = self.interactor.getAllQuestions()
        if(self.questionsArray.count > 0) {
            self.view.loadDataToView();
        } else {
            self.view.noDataAvailable()
        }
    }
    
    override func totalItems() -> NSInteger
    {
        return 4
    }
    
    override func itemAtIndex(index:NSInteger) -> AnyObject?
    {
        return self.questionsArray[self.currentQuestion]
    }
    
    override func cellTappedAtIndex(index:NSInteger)
    {
        let question:GKBQuestion = self.questionsArray[self.currentQuestion] as! GKBQuestion
        
        var option = "";
        switch (index) {
        case 0:
            option = question.optionOne!
        case 1:
            option = question.optionTwo!
        case 2:
            option = question.optionThree!
        case 3:
            option = question.optionFour!
        default:
            break
        }
        self.userSelectedAnswer = option;
    }
    
    func getQuestionNumber() -> Int {
        return self.currentQuestion;
    }
    
    func shouldLoadNextQuestion() -> Bool {
        return !(self.questionsArray.count == self.currentQuestion);
    }
    
    func nextButtonTapped() {
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
    
    func submitButtonTapped() {
        if self.timer.valid == true
        {
            self.timer.invalidate()
        }
        
        self.interactor.setUsersAnswers(self.questionsArray)
        
        let viewController : MVPResultViewImplementation = UIStoryboard.gameMVPStoryBoard().instantiateViewControllerWithIdentifier("CDResultChartVC") as! MVPResultViewImplementation
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
        let timeLeft = (GKBConstants.kTotalGameTime - self.currentTime)
        self.view.setTimerText(getTimeForSeconds(timeLeft))
    }
    
}
