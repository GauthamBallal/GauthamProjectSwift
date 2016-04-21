//
//  MVPResultsPresenter.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 21/04/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MVPResultsPresenter: MVPBasePresenter {

    var view:MVPResultView
    var interactor:MVPResultsInteractor
    
    required init(view:MVPResultView)
    {
        self.view = view
        self.interactor = MVPInteractor.sharedInstance
        super.init()
    }
    
}
