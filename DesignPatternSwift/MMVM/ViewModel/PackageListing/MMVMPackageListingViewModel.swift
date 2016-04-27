//
//  MMVMPackageListingViewModel.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 15/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MMVMPackageListingViewModel : MMVMPackageListingInterface {
    let testsArray : NSArray = GKBDataSourceManager.sharedGKBDataSourceManager().getAllTests()
    
    init() {
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
        let viewController : MMVMGamePlayViewController = UIStoryboard.gameMMVMStoryBoard().instantiateViewControllerWithIdentifier("CDGamePlayVC") as! MMVMGamePlayViewController
        viewController.viewModel.test = self.testsArray[indexPath.row] as? GKBTest
        GKBConstants.BASE_VIEWCONTROLLER.pushViewController(viewController, withAnimation: true)
    }
}
