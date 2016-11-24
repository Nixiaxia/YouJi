//
//  MainTravelViewController.swift
//  YouJi
//
//  Created by 逆夏夏 on 16/11/11.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit

class MainTravelViewController: UITableViewController, ParallaxHeaderViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftNavigationBar()
        
        createNav()
        
    }
    
    func createNav() {
        
        self.navigationController?.navigationBar.setMyBackgroundColor(UIColor(red: 0/255.0, green: 130/255.0, blue: 210/255.0, alpha: 0))
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, self.tableView.bounds.width, 100))
        imageView.image = UIImage(named: "1457667496349p1adhrbufv5ru161o14cu12penn93u")
        imageView.contentMode = .ScaleAspectFill
        
        let heardView = ParallaxHeaderView(style: .Thumb,subView: imageView, headerViewSize: CGSizeMake(self.tableView.frame.width, 64), maxOffsetY: 93, delegate: self)
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.tableView.tableHeaderView = heardView
        
    }
    
    func leftNavigationBar() {
        
        let leftBarBtn = UIBarButtonItem.init(title: "", style: .Plain, target: self, action: #selector(GuideViewController.backToPrevious))
        leftBarBtn.image = UIImage.init(named: "nav_back_icon_ipad")?.imageWithRenderingMode(.AlwaysOriginal)
        
        //消除左边空隙
        let spacer = UIBarButtonItem.init(barButtonSystemItem: .FixedSpace, target: self, action: nil)
        spacer.width = -10
        
        self.navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
        
    }
    
    func backToPrevious() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
//        cell?.textLabel?.text = "test\(indexPath.row)"
        
        return cell
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let heardView = self.tableView.tableHeaderView as! ParallaxHeaderView
        heardView.layoutHeaderViewWhenScroll(scrollView.contentOffset)
        
    }
}

