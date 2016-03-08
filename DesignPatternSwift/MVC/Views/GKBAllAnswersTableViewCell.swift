//
//  GKBAllAnswersTableViewCell.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 07/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class GKBAllAnswersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var optionsButton:UIButton!
    @IBOutlet weak var backgroundImageView:UIImageView!
    @IBOutlet weak var questionsLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Initialization code
        let editedImage = UIImage(named: "btn_norml")?.resizableImageWithCapInsets(UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0))
        self.backgroundImageView.image = editedImage
        self.optionsButton.titleLabel!.numberOfLines = 0;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setBackgroundForState(inState:Bool)
    {
        let imageName : String?
        imageName = inState ? "btn_on" : "btn_off";
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
    
    func constructCellWithQuestion(question : GKBQuestion)
    {
        let questionHeight :CGFloat = (question.question?.heightWithConstrainedWidth(280.0, font: UIFont.helvaticaRoman55WithSize(13.0)))!
        let answerHeight :CGFloat = (question.correctAnswer?.heightWithConstrainedWidth(280.0, font: UIFont.helvaticaLight45WithSize(13.0)))!
        self.questionsLabel.setHeight(questionHeight)
        
        self.optionsButton.setY(self.questionsLabel.frame.origin.y + questionHeight + 20)
        self.optionsButton.setHeight(answerHeight+30)
                
        let answer = question.userAnswer
        
        if answer.characters.count > 0
        {
            var userAnswerAppender : NSString = NSString(string: answer)
            userAnswerAppender = userAnswerAppender.stringByReplacingCharactersInRange(NSMakeRange(0, 3), withString: "")
            let correctAnswer = userAnswerAppender == question.correctAnswer ? true : false
            setBackgroundForState(correctAnswer)
            
            self.optionsButton.setAttributedTitle(NSAttributedString(string: answer), forState: .Normal)
        }
        else
        {
            setBackgroundForState(false)
            self.optionsButton.setAttributedTitle(NSAttributedString(string: "Not Answered"), forState: .Normal)
        }
        
        self.backgroundImageView.setY(10)
        self.backgroundImageView.setHeight(questionHeight+answerHeight+75)
    }
    

}
