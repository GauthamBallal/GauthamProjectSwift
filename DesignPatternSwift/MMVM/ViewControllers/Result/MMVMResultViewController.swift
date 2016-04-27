//
//  MMVMResultViewController.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 16/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MMVMResultViewController: GKBSuperViewController {
    let viewModel : MMVMResultViewModel = MMVMResultViewModel()
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setResult()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Methods
    
    func setResult()
    {
        self.resultLabel.text = self.viewModel.getResultText() as String
    }
    
    // MARK: - Action Methods
    
    @IBAction func showAnswerButtonTapped(sender: AnyObject) {
        self.viewModel.showAllAnswerButonTapped()
    }
}
