//
//  MVPResultViewImplementation.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 21/04/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MVPResultViewImplementation: GKBSuperViewController, MVPResultView {

    var presenter:MVPResultsPresenter!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.presenter = MVPResultsPresenter(view: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let navBar : GKBNavigationBar = self.navigationController?.navigationBar.viewWithTag(GKBConstants.kCustomNavigationBarTag) as! GKBNavigationBar
        navBar.shouldHideBackButton(true)
        navBar.shouldHideHintButton(true)
        self.presenter.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadDataToView() {
        self.resultLabel.text = self.presenter.getResultText()
    }
    
    @IBAction func showAnswerButtonTapped(sender: UIButton) {
        self.presenter.showAllAnswerButonTapped()
    }
    

}
