//
//  MVPInteractor.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 21/04/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MVPInteractor:MVPPackageListingInteractor,MVPGamePlayInteractor,MVPResultsInteractor,MVPAllAnswerInteractor{
    static let sharedInstance = MVPInteractor()

    var answers:NSMutableArray = []
    
    var selectedTest : GKBTest? {
        didSet{
            for question in self.selectedTest!.questions! {
                self.answers.addObject(question)
            }
        }
    }

    func getAllTests() -> NSArray
    {
        return GKBDataSourceManager.sharedGKBDataSourceManager().getAllTests()
    }
    
    func setSelectedTest(test:GKBTest)
    {
        self.selectedTest = test
    }
    
    func getAllQuestions() -> NSArray
    {
        return answers
    }
    
    func setUsersAnswers(answers:NSArray)
    {
        self.answers = NSMutableArray(array: answers)
    }
}
