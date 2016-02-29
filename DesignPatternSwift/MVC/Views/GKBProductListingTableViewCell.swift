//
//  GKBProductListingTableViewCell.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 29/02/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class GKBProductListingTableViewCell: UITableViewCell {

    @IBOutlet weak var imageTextLabel: UILabel!
    @IBOutlet weak var testTitleLabel: UILabel!
    @IBOutlet weak var testDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func constructCellWith(test : GKBTest)
    {
        imageTextLabel.text = test.testName;
        testTitleLabel.text = "Test " + (test.testID?.stringValue)!;
        testDescriptionLabel.text = test.testDescription;
    }

}
