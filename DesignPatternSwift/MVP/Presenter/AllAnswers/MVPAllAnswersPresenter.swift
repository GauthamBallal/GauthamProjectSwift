//
//  MVPAllAnswersPresenter.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 21/04/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MVPAllAnswersPresenter: MVPBasePresenter {
    var answers:NSArray?

    var view:MVPAllAnswersView
    var interactor:MVPAllAnswerInteractor
    
    required init(view:MVPAllAnswersView)
    {
        self.view = view
        self.interactor = MVPInteractor.sharedInstance
        super.init()
    }
    
    override func loadData()
    {
        self.answers = interactor.getAllQuestions()
        if self.answers!.count > 0 {
            self.view.loadDataToView()
        }
    }
    
    override func totalItems() -> NSInteger
    {
        if let answers = self.answers {
            return answers.count
        }
        return 0
    }
    
    override func itemAtIndex(index:NSInteger) -> AnyObject?
    {
        if self.answers!.count > index {
            return self.answers![index]
        } else {
            return nil
        }
    }
    
    func goToMainMenuTapped() {
        GKBConstants.BASE_VIEWCONTROLLER.popViewRootViewControllerAnimated(true)
    }
    
}
