//
//  GKBOptionsTableViewCell.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 01/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class GKBOptionsTableViewCell: UITableViewCell {

    @IBOutlet weak var optionsButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        optionsButton.titleLabel!.numberOfLines = 0;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setBackgrounForState(selected)
        // Configure the view for the selected state
    }
    
    func setBackgrounForState(inState:Bool)
    {
        let imageName : String?
        imageName = selected ? "btn_on" : "btn_norml";
        let editedImage = UIImage(named: imageName!)?.resizableImageWithCapInsets(UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0))
        self.optionsButton.setBackgroundImage(editedImage, forState: .Normal)
    }
    
    func getAttributedStringFromString(inString:String) -> NSAttributedString
    {
        let attSting : NSMutableAttributedString = NSMutableAttributedString(string: inString, attributes: [NSFontAttributeName:UIFont.helvaticaLight45WithSize(13.0),NSForegroundColorAttributeName:UIColor.blackColor()])
        if(inString.characters.count > 4){
            attSting.addAttributes([NSFontAttributeName:UIFont.helvaticaRoman55WithSize(13.0)], range: NSMakeRange(0, 3))
        }
        
        return attSting;
    }
    
    
    func heightForText(optionsText:String) -> CGFloat
    {
        let height = optionsText.heightWithConstrainedWidth(self.optionsButton.frame.size.width, font: UIFont.helvaticaLight45WithSize(13.0)) + 2
        return height
    }
    
    func setOptionsText(optionsText:String)
    {
        self.optionsButton.setHeight(heightForText(optionsText)+30)
        self.optionsButton.setAttributedTitle(getAttributedStringFromString(optionsText), forState: .Normal)
    }

}
