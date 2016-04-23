//
//  MVPAllAnswersViewImplementation.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 21/04/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MVPAllAnswersViewImplementation: GKBSuperViewController,MVPAllAnswersView {

    var presenter:MVPAllAnswersPresenter!
    @IBOutlet weak var allAnswersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.presenter = MVPAllAnswersPresenter(view: self)

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadDataToView() {
        self.allAnswersTableView.reloadData()
    }
    

    // MARK: - Private Method
    
    func heightForIndexPath(indexPath:NSIndexPath) -> CGFloat
    {
        let question : GKBQuestion = self.presenter.itemAtIndex(indexPath.row) as! GKBQuestion
        let questionHeight :CGFloat = (question.question!.heightWithConstrainedWidth(280.0, font: UIFont.helvaticaRoman55WithSize(13.0)))
        let answerHeight :CGFloat = (question.correctAnswer!.heightWithConstrainedWidth(280.0, font: UIFont.helvaticaLight45WithSize(13.0)))
        
        return questionHeight + answerHeight + 85;
    }
    
    // MARK: -  TableViewDelegate
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.presenter.totalItems()
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let question : GKBQuestion = self.presenter.itemAtIndex(indexPath.row) as! GKBQuestion
        let cell : GKBAllAnswersTableViewCell = tableView.dequeueReusableCellWithIdentifier("AllAnswersCell") as! GKBAllAnswersTableViewCell
        cell.constructCellWithQuestion(question);
        cell.questionsLabel.text = NSString(format: "%d. %@",indexPath.row + 1,question.question!) as String;
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let cellheight = heightForIndexPath(indexPath)
        return cellheight
    }

    @IBAction func goToMainButtonTapped(sender: UIButton) {
        self.presenter.goToMainMenuTapped()
    }
}
