//
//  MMVMAllAnswersInterface.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 16/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import Foundation

protocol MMVMAllAnswersInterface
{
    func numberOfRows() -> NSInteger
    func getQuestionTextForRow(row :NSInteger) -> NSString
    func getAnswerTextForRow(row :NSInteger) -> NSString
    func getUserAnswerTextForRow(row :NSInteger) -> NSString
    
    func goToMainMenuTapped()
}
