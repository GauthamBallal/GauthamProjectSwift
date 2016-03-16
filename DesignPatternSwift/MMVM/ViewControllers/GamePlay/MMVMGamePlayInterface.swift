//
//  MMVMGamePlayInterface.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 15/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import Foundation

protocol MMVMGamePlayInterface
{
    typealias MMVMTimerCallack = (timeToSet:NSString?) -> (Void)
    
    var timerCallback:GKBConstants.MMVMTimerCallack? { get set }
    var currentTime:Double { get set }
    var userSelectedAnswer:NSString { get set }
    var timer:NSTimer { get set }
    var questionsArray:NSMutableArray { get set }
    var currentQuestion:Int { get set }
    
    func numberOfRows() -> NSInteger
    func optionForRow(row :NSInteger) -> NSString
    func getQuestionText() -> NSString
    func getHint() -> NSString
    func getQuestionNumber() -> NSInteger
    func setInitialTime(callback : MMVMTimerCallack)
    func selectedAnswerAtIndexPath(indexPath : NSIndexPath)
    func shouldLoadNextQuestion() -> Bool
    func nextButtonTapped()
    func submitButtonTapped()
}