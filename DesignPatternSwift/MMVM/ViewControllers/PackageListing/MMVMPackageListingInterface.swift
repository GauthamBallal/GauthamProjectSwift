//
//  MMVMPackageListingInterface.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 15/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import Foundation

protocol MMVMPackageListingInterface
{
    func numberOfRows() -> NSInteger
    func titleForRow(row :NSInteger) -> NSString
    func descriptionForRow(row :NSInteger) -> NSString
    func imageTitleForRow(row :NSInteger) -> NSString

    func tableCellTapped(indexPath : NSIndexPath)
}
