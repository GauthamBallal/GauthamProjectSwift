//
//  MMVMAllAnswersTableViewCell.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 16/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MMVMAllAnswersTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel:UILabel!
    @IBOutlet weak var answerButton:UIButton!
    @IBOutlet weak var backgroundImageView:UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let editedImage = UIImage(named: "btn_norml")?.resizableImageWithCapInsets(UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0))
        self.backgroundImageView.image = editedImage
        self.answerButton.titleLabel!.numberOfLines = 0;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBackgroundForState(selected:Bool)
    {
        let imageName : String?
        imageName = selected ? "btn_on" : "btn_off";
        let editedImage = UIImage(named: imageName!)?.resizableImageWithCapInsets(UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0))
        self.answerButton.setBackgroundImage(editedImage, forState: .Normal)
    }

}
