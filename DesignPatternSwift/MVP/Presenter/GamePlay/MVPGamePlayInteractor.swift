//
//  MVPGamePlayInteractor.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 21/04/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import Foundation

protocol MVPGamePlayInteractor
{
    func getAllQuestions() -> NSArray
    func setUsersAnswers(test:NSArray)
}