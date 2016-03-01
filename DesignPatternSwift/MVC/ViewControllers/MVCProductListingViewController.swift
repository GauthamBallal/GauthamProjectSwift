//
//  MVPProductListingViewController.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 29/02/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MVCProductListingViewController: GKBSuperViewController {

    @IBOutlet weak var productListingTableView: UITableView!
    var testsArray : NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.testsArray = GKBDataSourceManager.sharedGKBDataSourceManager().getAllTests()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: -  TableViewDelegate
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return testsArray.count
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let test:GKBTest = testsArray[indexPath.row] as! GKBTest;
        let cell : GKBProductListingTableViewCell = tableView.dequeueReusableCellWithIdentifier("ListingCell") as! GKBProductListingTableViewCell
        cell.constructCellWith(test);
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let viewController : MVCGamePlayViewController = UIStoryboard.gameMVCStoryBoard().instantiateViewControllerWithIdentifier("CDGamePlayVC") as! MVCGamePlayViewController

        viewController.test = testsArray[indexPath.row] as? GKBTest
        GKBConstants.BASE_VIEWCONTROLLER.pushViewController(viewController, withAnimation: true)
    }

}
