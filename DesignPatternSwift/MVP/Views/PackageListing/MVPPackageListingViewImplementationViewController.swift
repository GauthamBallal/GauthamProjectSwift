//
//  MVPPackageListingViewImplementationViewController.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 21/04/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MVPPackageListingViewImplementationViewController: GKBSuperViewController,MVPPackageListingView {
    @IBOutlet weak var listingTableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    var presenter:MVPPackageListingPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MVPPackageListingPresenter(view: self)
        
        self.presenter.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -  MVPPackageListingView
    
    func loadDataToView()
    {
        self.listingTableView .reloadData()
    }
    
    func noDataAvailable()
    {
        self.errorLabel.hidden = false
    }

    // MARK: -  UITableView
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.presenter.totalItems()
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let test:GKBTest = self.presenter.itemAtIndex(indexPath.row) as! GKBTest;
        let cell : GKBProductListingTableViewCell = tableView.dequeueReusableCellWithIdentifier("ListingCell") as! GKBProductListingTableViewCell
        cell.constructCellWith(test);
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.presenter.cellTappedAtIndex(indexPath.row)
    }
    
}
