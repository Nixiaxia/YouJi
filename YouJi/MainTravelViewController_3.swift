//
//  MainTravelViewController_3.swift
//  YouJi
//
//  Created by 逆夏夏 on 2016/11/22.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit
import JKCategories
import Alamofire
import YYWebImage
import SnapKit
import MBProgressHUD

class MainTravelViewController_3: ViewController {
    
    var urlString: String?
    
    var tableView = UITableView()
    
    // 顶部图片的高度
    let topImageHeight: CGFloat = 150
    
    var blurView: UIVisualEffectView?
    
    var backImage: UIImageView?
    
    var specialmodel = specialTableModel()
    
    var img_url: String = ""
    
    var leftButtonTitle: String?
    
    var headImage: String?
    
    var name: String?
    
    var topImage = UIImage()
    
    var title_1: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        leftNavigationBar()
        
        download()
        
        createTableView()
       
    }
   
    func createTableView() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), style: .Plain)
        tableView.showsHorizontalScrollIndicator = false
        //        tableView?.separatorStyle = .None
        
        tableView.estimatedRowHeight = 500
        
        tableView.registerNibOf(SpecialTableViewCell)
//        tableView.allowsSelection = false
        //        tableView?.contentInset = UIEdgeInsetsMake(topImageHeight, 0, 0, 0)
        
        //        tableView?.delegate = self
        //        tableView?.dataSource = self
        
        let backView = UIView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, topImageHeight));
        let headerImageView = UIImageView()
        headerImageView.frame = CGRectMake(0, -64, self.view.frame.size.width, topImageHeight + 64)
//        headerImageView.image = UIImage.init(named: "1457667496349p1adhrbufv5ru161o14cu12penn93u")
        headerImageView.yy_setImageWithURL(NSURL(string: img_url), placeholder: nil)
        backImage = headerImageView
        
        headerImageView.contentMode = .ScaleAspectFill
        headerImageView.clipsToBounds = true
        
        let labelName = UILabel()
        labelName.text = self.name
        labelName.textColor = UIColor.whiteColor()
        labelName.font = UIFont.systemFontOfSize(25)
        headerImageView.addSubview(labelName)
        labelName.snp_makeConstraints { (make) in
            make.top.equalTo(90)
            make.centerX.equalTo(0)
        }
        
        let labelLine = UILabel()
        labelLine.text = "——————————————"
        labelLine.textColor = UIColor.whiteColor()
        headerImageView.addSubview(labelLine)
        labelLine.snp_makeConstraints { (make) in
            make.top.equalTo(labelName.snp_bottom).offset(1)
            make.centerX.equalTo(0)
        }
        
        let labelTitle = UILabel()
        labelTitle.text = self.title_1
        labelTitle.textColor = UIColor.whiteColor()
        labelTitle.font = UIFont.systemFontOfSize(15)
        headerImageView.addSubview(labelTitle)
        labelTitle.snp_makeConstraints { (make) in
            make.top.equalTo(labelLine.snp_bottom).offset(1)
            make.centerX.equalTo(0)
        }
        
        backView.addSubview(headerImageView)
        tableView.tableHeaderView = backView
        
        let blurEffect = UIBlurEffect(style: .Light)
        let blurView_1 = UIVisualEffectView(effect: blurEffect)
        blurView_1.frame.size = CGSizeMake(backView.frame.width, backView.frame.height+64)
        blurView_1.alpha = 0.0
        
        blurView = blurView_1
        
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.contentOffset = CGPointMake(0, -64)
        
        headerImageView.addSubview(blurView!)
        
        self.view.addSubview(tableView)
        
    }
    
    func download() {
       
        Alamofire.request(.GET, urlString!).responseJSON { (response) in
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            if response.result.isSuccess {
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                let json = response.result.value
                self.specialmodel.yy_modelSetWithJSON(json!)

                
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            })
            
        }
        
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
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //        print(tableView?.contentOffset.y)
        scrollViewDidScroll(tableView)
        
        //            self.navigationController?.navigationBar.setBackgroundImage(self.topImage,
        //                                                                        forBarMetrics: .Default)
        //
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
        self.navigationController?.navigationBar.barStyle = .Default
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollViewDidScroll(tableView)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(self.topImage, forBarMetrics: .Default)
        //        self.navigationController?.navigationBar.translucent = false
        
    }
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        //        self.navigationController?.navigationBar.setBackgroundImage(nil,
        //                                                                    forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = nil
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainTravelViewController_3: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (specialmodel.article_sections?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: SpecialTableViewCell = tableView.dequeueReusableCell()
        
        cell.selectionStyle = .None
        
        let model = specialmodel.article_sections![indexPath.row]
        
        cell.configWithModel(model)
        
        return cell
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
//                return 300
    }

}

extension MainTravelViewController_3{
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offY = scrollView.contentOffset.y
        
        blurView?.alpha = (offY + 64) / (topImageHeight - 64)
        
        if offY < 0 {
            backImage?.frame.origin.y = offY + topImageHeight - 150
            backImage?.frame.size.height = -offY + 150
        }
        
        if offY >= topImageHeight - 64 {
            
            let a = backImage?.jk_screenshot().jk_croppedImage(CGRectMake(0, (backImage?.jk_size.height)! * (backImage?.image?.scale)! - 64 * (backImage?.image?.scale)!, (self.tableView.frame.width) * (backImage?.image?.scale)!, 64 * (backImage?.image?.scale)!)).jk_resizedImage(CGSizeMake((self.tableView.frame.size.width), 64), interpolationQuality: CGInterpolationQuality.High)
            
            if backImage?.window != nil {
                self.topImage = a!
            }
            self.navigationController?.navigationBar.setBackgroundImage(topImage, forBarMetrics: .Default)
            
        }else {
            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        }
        
    }
    
}







