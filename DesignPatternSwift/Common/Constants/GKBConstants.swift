//
//  GKBConstants.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 29/02/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit
import Foundation

@objc class GKBConstants: NSObject {
    
    static let sharedConstants = GKBConstants()
    
    override init() {
        
    }
    
    static let APP_DELEGATE : AppDelegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
    static let BASE_VIEWCONTROLLER : ViewController = ((APP_DELEGATE.window?.rootViewController as! UINavigationController).viewControllers[0]) as! ViewController
    
    typealias MMVMTimerCallack = (timeToSet:String?) -> (Void)

    static let kCDTestID = "testID"
    static let kCDTestName = "testName"
    static let kCDTestDescription = "testDescription"
    static let kCDQuestionID = "questionID"
    static let kCDQuestion = "question"
    static let kCDQuestionOption1 = "optionOne"
    static let kCDQuestionOption2 = "optionTwo"
    static let kCDQuestionOption3 = "optionThree"
    static let kCDQuestionOption4 = "optionFour"
    static let kCDQuestionCorrectAnswer = "correctAnswer"
    static let kCDQuestionHint = "hint"
    
    static let  kTotalGameTime = 240.0
    static let  kCustomNavigationBarTag = 9045
    static let  kHintNotification = "HintTapped"
    
    static let IS_RETINA_4 = UIScreen.mainScreen().bounds.size.height == 568 || UIScreen.mainScreen().bounds.size.width == 568
    
    static let IS_IPHONE5 = UIScreen.mainScreen().bounds.size.height == 568 ? true:false
    
    enum DesignPattern : Int {
        case eMVC = 0
        case eMMVM,eMVP
    }
    
}
