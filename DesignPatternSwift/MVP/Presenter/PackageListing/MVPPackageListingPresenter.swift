//
//  MVPPackageListingPresenter.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 21/04/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MVPPackageListingPresenter: MVPBasePresenter {
    var testsArray:NSArray = []
    var view:MVPPackageListingView
    var interactor:MVPPackageListingInteractor
    
    required init(view:MVPPackageListingView)
    {
        self.view = view
        self.interactor = MVPInteractor.sharedInstance
        super.init()
    }
    
    override func loadData()
    {
        self.testsArray = interactor.getAllTests()
        if self.testsArray.count > 0 {
            self.view.loadDataToView()
        } else {
            self.view.noDataAvailable()
        }
    }
    
    override func totalItems() -> NSInteger
    {
        return self.testsArray.count
    }
    
    override func itemAtIndex(index:NSInteger) -> AnyObject?
    {
        if self.testsArray.count > index {
            return self.testsArray[index]
        } else {
            return nil
        }
    }
    
    override func cellTappedAtIndex(index:NSInteger)
    {
        self.interactor.setSelectedTest(self.testsArray[index] as! GKBTest)
        let viewController : MVPGamePlayViewImplementation = UIStoryboard.gameMVPStoryBoard().instantiateViewControllerWithIdentifier("CDGamePlayVC") as! MVPGamePlayViewImplementation
        GKBConstants.BASE_VIEWCONTROLLER.pushViewController(viewController, withAnimation: true)
    }
}
