//
//  MMVMPackageListingViewController.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 15/03/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class MMVMPackageListingViewController: GKBSuperViewController {
    @IBOutlet weak var productListingTableView: UITableView!

    var viewModel : MMVMPackageListingViewModel = MMVMPackageListingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: -  TableViewDelegate
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return viewModel.numberOfRows()
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell : GKBProductListingTableViewCell = tableView.dequeueReusableCellWithIdentifier("ListingCell") as! GKBProductListingTableViewCell
        (cell.viewWithTag(121) as! UILabel).text = viewModel.titleForRow(indexPath.row) as String;
        (cell.viewWithTag(122) as! UILabel).text = viewModel.imageTitleForRow(indexPath.row) as String;
        (cell.viewWithTag(123) as! UILabel).text = viewModel.descriptionForRow(indexPath.row) as String;

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        viewModel.tableCellTapped(indexPath)
    }


}
