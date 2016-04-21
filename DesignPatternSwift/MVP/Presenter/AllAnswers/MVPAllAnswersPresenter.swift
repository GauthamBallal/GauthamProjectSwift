//
//  MVPAllAnswersPresenter.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 21/04/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MVPAllAnswersPresenter: MVPBasePresenter {

    var view:MVPAllAnswersView
    var interactor:MVPAllAnswerInteractor
    
    required init(view:MVPAllAnswersView)
    {
        self.view = view
        self.interactor = MVPInteractor.sharedInstance
        super.init()
    }
    
}
