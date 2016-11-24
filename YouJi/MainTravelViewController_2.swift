//
//  MainTravelViewController_2.swift
//  YouJi
//
//  Created by 逆夏夏 on 16/11/12.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit
import JKCategories
import Alamofire
import YYWebImage
import SnapKit
import MBProgressHUD


class MainTravelViewController_2: ViewController {
    
    // 顶部图片的高度
    let topImageHeight: CGFloat = 150
    
    var blurView: UIVisualEffectView?
    
    var backImage: UIImageView?

    var tableView: UITableView?

    var tripsmodel = tripsModel()
    
    var table = UITableView()

    var id: Int = 323121
    
    var string_bakcImg: String = ""
    
    var leftButtonTitle: String?
    
    var headImage: String?
    
    var headTitle: String?
    
    var startDate: String?
    
    var days: String?
    
    var photoCount: String?
    
    var topImage = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        download()
        
        leftNavigationBar()
      
        createTableView()
        
    }
    
    func createTableView() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), style: .Plain)
        tableView?.showsHorizontalScrollIndicator = false
//        tableView?.separatorStyle = .None
        
        tableView?.estimatedRowHeight = 400
        
        tableView?.registerNibOf(TripsTableViewCell)
        tableView?.allowsSelection = false
//        tableView?.contentInset = UIEdgeInsetsMake(topImageHeight, 0, 0, 0)
        
//        tableView?.delegate = self
//        tableView?.dataSource = self
        
        let backView = UIView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, topImageHeight));
        let headerImageView = UIImageView()
        headerImageView.frame = CGRectMake(0, -64, self.view.frame.size.width, topImageHeight + 64)
//        headerImageView.image = UIImage.init(named: "1457667496349p1adhrbufv5ru161o14cu12penn93u")
        headerImageView.yy_setImageWithURL(NSURL(string: string_bakcImg), placeholder: nil)
        backImage = headerImageView
        
        headerImageView.contentMode = .ScaleAspectFill
        headerImageView.clipsToBounds = true
        
        let headUrl = NSURL(string: headImage!)
        let headImage_1 = UIImageView()
        headImage_1.yy_imageURL = headUrl
        headImage_1.layer.cornerRadius = 20
        headImage_1.layer.masksToBounds = true
        headImage_1.layer.borderColor = UIColor.whiteColor().CGColor
        headImage_1.layer.borderWidth = 2
        headerImageView.addSubview(headImage_1)
        headImage_1.snp_makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.left.equalTo(8)
            make.bottom.equalTo(-8)
        }
        
        let label = UILabel()
        label.text = "\(startDate!) / \(days!)天 / \(photoCount!)图"
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.systemFontOfSize(14)
        headerImageView.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.bottom.equalTo(-8)
            make.left.equalTo(headImage_1.snp_right).offset(5)
        }
        
        let label_1 = UILabel()
        label_1.text = self.headTitle!
        label_1.textColor = UIColor.whiteColor()
        label_1.font = UIFont.systemFontOfSize(15)
        headerImageView.addSubview(label_1)
        label_1.snp_makeConstraints { (make) in
            make.left.equalTo(headImage_1.snp_right).offset(5)
            make.bottom.equalTo(label.snp_top).offset(1)
        }
        
        backView.addSubview(headerImageView)
        tableView?.tableHeaderView = backView
        
        let blurEffect = UIBlurEffect(style: .Light)
        let blurView_1 = UIVisualEffectView(effect: blurEffect)
        blurView_1.frame.size = CGSizeMake(backView.frame.width, backView.frame.height+64)
        blurView_1.alpha = 0.0
        
        blurView = blurView_1
        
        tableView?.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView?.contentOffset = CGPointMake(0, -64)
        
        headerImageView.addSubview(blurView!)
        
        self.view.addSubview(tableView!)
        
    }
    
    func download() {
        
//        print(id)
        let url = NSURL(string: String(format: "http://chanyouji.com/api/trips/%d.json", id))
//        print(url!)
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        Alamofire.request(.GET, url!).responseJSON { (response) in
            
            if response.result.isSuccess {
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                let json = response.result.value
                self.tripsmodel.yy_modelSetWithJSON(json!)
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView?.delegate = self
                self.tableView?.dataSource = self
                self.tableView?.reloadData()
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
        scrollViewDidScroll(tableView!)
        
//            self.navigationController?.navigationBar.setBackgroundImage(self.topImage,
//                                                                        forBarMetrics: .Default)
//
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
        self.navigationController?.navigationBar.barStyle = .Default
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
            scrollViewDidScroll(tableView!)
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
    
//    override func viewDidDisappear(animated: Bool) {
//        super.viewDidDisappear(animated)
//        
//        self.navigationController?.navigationBar.setBackgroundImage(nil,
//                                                                    forBarMetrics: .Default)
//        self.navigationController?.navigationBar.shadowImage = nil
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainTravelViewController_2: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
//        print(tripsmodel)
        return (tripsmodel.trip_days.count)
        
    }
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "第 \(String(UnicodeScalar(65 + section)))组标题"
//    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view_1 = UIView.init(frame: CGRectMake(0, 0, self.view.bounds.size.width, 50))
        
        view_1.backgroundColor = UIColor.whiteColor()
        
//        var days = tripsmodel.trip_days[section]
        
        let label_1 = UILabel.init(frame: CGRectMake(0, 0, self.view.bounds.size.width, 30))
        
        label_1.text = "DAY\(section + 1)"
        
        label_1.textAlignment = .Center
        
        view_1.addSubview(label_1)
        
        return view_1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
//        return 500
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (tripsmodel.trip_days[section].notes?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: TripsTableViewCell = tableView.dequeueReusableCell()
        
        cell.selectionStyle = .None
        
        let model = tripsmodel.trip_days[indexPath.section].notes![indexPath.row]
//        print(model.desc)
//        let model_1 = self.tripsmodel.trip_days[indexPath.section].nodes![indexPath.row]
        var model_1 = nodes_Model()
        var notFirst = false
        
        let nodes = tripsmodel.trip_days[indexPath.section].nodes!
        
        for index in 0..<nodes.count{
            
            if let locate = nodes[index].notes?.indexOf(model) {
                
                model_1 = nodes[index]
                
                if locate == 0 {
                    notFirst = true
                }
                break
            }
        }

        
//        cell.notFirst = false
//        for index in 0..<nodes.count{
//            if nodes[index].notes!.contains(model) {
//                model_1 = nodes[index]
//            }
//            if nodes[index].notes?.indexOf(model) != 0 {
//                cell.notFirst = false
//            }else{
//                cell.notFirst = true
//            }
//        }
        
        cell.configWithModel(model_1, notesmodel: model, isFirst: notFirst)
        
        return cell
    }

}

extension MainTravelViewController_2 {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offY = scrollView.contentOffset.y
        
        blurView?.alpha = (offY + 64) / (topImageHeight - 64)
        
        if offY < 0 {
            backImage?.frame.origin.y = offY + topImageHeight - 150
            backImage?.frame.size.height = -offY + 150
        }
        
        if offY >= topImageHeight - 64 {
            
            let a = backImage?.jk_screenshot().jk_croppedImage(CGRectMake(0, (backImage?.jk_size.height)! * (backImage?.image?.scale)! - 64 * (backImage?.image?.scale)!, (self.tableView?.frame.width)! * (backImage?.image?.scale)!, 64 * (backImage?.image?.scale)!)).jk_resizedImage(CGSizeMake((self.tableView?.frame.size.width)!, 64), interpolationQuality: CGInterpolationQuality.High)
        
            if backImage?.window != nil {
                self.topImage = a!
            }
            self.navigationController?.navigationBar.setBackgroundImage(topImage, forBarMetrics: .Default)
            
        }else {
        
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        }
      
    }
    
}
