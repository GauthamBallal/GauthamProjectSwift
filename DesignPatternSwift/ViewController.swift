//
//  ViewController.swift
//  DesignPatternSwift
//
//  Created by Gautham Krishna Ballal on 29/02/16.
//  Copyright © 2016 Gautham Krishna Ballal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let navBar : GKBNavigationBar = (((NSBundle.mainBundle().loadNibNamed("GKBNavigationBar", owner: self, options: nil)) as NSArray).objectAtIndex(0) as! GKBNavigationBar);
        navBar.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: navBar.frame.size.height);
        self.navigationController?.navigationBar.addSubview(navBar);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getIdentifierForRow(row:NSInteger) -> String
    {
        var identifier:String;
        
        switch (row){
        case 0:
            identifier = "mvcCell"
        case 1:
            identifier = "mmvmCell"
        default:
            identifier = "mvpCell"
        }
        return identifier;
    }
    
    func displayMVCHomeController()
    {
        let viewController : UIViewController = UIStoryboard.gameMVCStoryBoard().instantiateViewControllerWithIdentifier("CDPackageListingVC")
        self.pushViewController(viewController, withAnimation: true)
    }
    
    func displayMMVMHomeController()
    {
        let viewController : UIViewController = UIStoryboard.gameMMVMStoryBoard().instantiateViewControllerWithIdentifier("CDPackageListingVC")
        self.pushViewController(viewController, withAnimation: true)
    }
    
    func displayMVPHomeController()
    {
        let viewController : UIViewController = UIStoryboard.gameMVPStoryBoard().instantiateViewControllerWithIdentifier("CDPackageListingVC")
        self.pushViewController(viewController, withAnimation: true)
    }
    
    // MARK: -  NavigationController
    
    func pushViewController(viewControllerToBePushed : UIViewController, withAnimation:Bool)
    {
        let navBar : GKBNavigationBar = self.navigationController?.navigationBar.viewWithTag(GKBConstants.kCustomNavigationBarTag) as! GKBNavigationBar
        navBar.shouldHideBackButton(false);
        navBar.shouldHideHintButton(true)
        self.navigationController?.pushViewController(viewControllerToBePushed, animated: withAnimation)
        
    }

    func popViewControllerAnimated(animated :Bool)
    {
        let navBar : GKBNavigationBar = self.navigationController?.navigationBar.viewWithTag(GKBConstants.kCustomNavigationBarTag) as! GKBNavigationBar
        if self.navigationController?.viewControllers.count == 2 {
            navBar.shouldHideBackButton(true);
        }
        navBar.shouldHideHintButton(true)
        self.navigationController?.popViewControllerAnimated(animated);
    }
    
    func popViewRootViewControllerAnimated(animated :Bool)
    {
        let navBar : GKBNavigationBar = self.navigationController?.navigationBar.viewWithTag(GKBConstants.kCustomNavigationBarTag) as! GKBNavigationBar
        navBar.shouldHideBackButton(true);
        navBar.shouldHideHintButton(true)
        self.navigationController?.popToRootViewControllerAnimated(animated);
    }



    // MARK: -  TableViewDelegate
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(getIdentifierForRow(indexPath.row) as String)
        return (cell?.frame.size.height)!;
    }
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3;
    }

    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(getIdentifierForRow(indexPath.row) as String)
        return cell!;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        switch(indexPath.row)
        {
            case GKBConstants.DesignPattern.eMVC.rawValue:
                displayMVCHomeController();
            case GKBConstants.DesignPattern.eMMVM.rawValue:
                displayMMVMHomeController();
            default:
                displayMVPHomeController();
        }
        
    }

    
}

