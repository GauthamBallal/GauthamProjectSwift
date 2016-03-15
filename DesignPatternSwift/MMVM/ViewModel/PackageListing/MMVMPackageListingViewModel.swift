//
//  MMVMPackageListingViewModel.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 15/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MMVMPackageListingViewModel : MMVMPackageListingInterface {
    var testsArray : NSArray = []
    
    init() {
        self.testsArray = GKBDataSourceManager.sharedGKBDataSourceManager().getAllTests()
    }
    
    func numberOfRows() -> NSInteger
    {
        return testsArray.count
    }
    
    func titleForRow(row :NSInteger) -> NSString
    {
        let test:GKBTest = testsArray[row] as! GKBTest;
        return "Test " + (test.testID?.stringValue)!
    }
    func descriptionForRow(row :NSInteger) -> NSString
    {
        let test:GKBTest = testsArray[row] as! GKBTest;
        return test.testDescription!
    }
    func imageTitleForRow(row :NSInteger) -> NSString
    {
        let test:GKBTest = testsArray[row] as! GKBTest;
        return test.testName!
    }
    
    func tableCellTapped(indexPath : NSIndexPath)
    {
        let viewController : MVCGamePlayViewController = UIStoryboard.gameMVCStoryBoard().instantiateViewControllerWithIdentifier("CDGamePlayVC") as! MVCGamePlayViewController
        
        viewController.test = testsArray[indexPath.row] as? GKBTest
        GKBConstants.BASE_VIEWCONTROLLER.pushViewController(viewController, withAnimation: true)
    }
}
