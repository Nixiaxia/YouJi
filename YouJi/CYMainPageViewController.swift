//
//  CYMainPageViewController.swift
//  YouJi
//
//  Created by 逆夏夏 on 16/10/26.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import Alamofire
import MJRefresh
import MBProgressHUD

class CYMainPageViewController: ViewController {
    
    var cellModels: [AnyObject] = []
    var cellModels_1: [AnyObject] = []
    
    var curPage: Int = 1
    
//    var cellModel: YJMainPageModel!
    
    let numOfPages = 2
    
    let pageWidth = UIScreen.mainScreen().bounds.width
    let pageHeight = UIScreen.mainScreen().bounds.height
    
    let scrollView = UIScrollView()
    
    var control: BetterSegmentedControl!
    
    var views = [UITableView]() 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        betterSegmentedController()
        
        createScrollView()
       
        navBarItem()
        
    }
    
    func navBarItem() { 
        
        let img = UIImage(named: "nav_setting_icon_ipad")?.imageWithRenderingMode(.AlwaysOriginal)
        let img_1 = UIImage(named: "nav_search_icon_ipad")?.imageWithRenderingMode(.AlwaysOriginal)
        
        let item1 = UIBarButtonItem(image: img, style: .Plain, target: self, action: #selector(CYMainPageViewController.leftAction))
        self.navigationItem.leftBarButtonItem = item1
//        let item2 = UIBarButtonItem(image: img_1, style: .Plain, target: self, action: #selector(CYMainPageViewController.rightAction))
//        self.navigationItem.rightBarButtonItem = item2
//        
    }
    
    func leftAction() {
        let settingVC = SettingViewController()
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    func rightAction() {
        
    }
    
    func createScrollView(){
        
        //scrollView的初始化
        scrollView.frame = CGRectMake(0,74+44, pageWidth, pageHeight)
        
        //为了让内容横向滚动，设置横向内容宽度为2个页面的宽度总和
        scrollView.contentSize=CGSizeMake(pageWidth*CGFloat(numOfPages),0)
        scrollView.backgroundColor = UIColor.whiteColor()
        
        scrollView.pagingEnabled = true
        
        //关闭回弹效果
        scrollView.bounces = false
        
        scrollView.showsHorizontalScrollIndicator = false
   
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.scrollsToTop = false
        
        scrollView.delegate = self
        
        //添加子页面
        for i in 0..<numOfPages{
            
            let travelView = UITableView()
            
            travelView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(CYMainPageViewController.refresh))
            
            travelView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(CYMainPageViewController.loadMore))
            
            travelView.frame = CGRectMake(CGFloat((view.bounds.size.width)*CGFloat(i)),0, CGFloat((view.bounds.size.width)), CGFloat(view.bounds.size.height - 165))
            travelView.backgroundColor = UIColor.whiteColor()
            
            travelView.separatorStyle = .None
            
//            travelView.contentMode = UIViewContentMode.ScaleAspectFill
            
            travelView.showsVerticalScrollIndicator = false
            
            travelView.delegate = self
            
            travelView.dataSource = self
            
//            travelView.allowsSelection = false
            
            travelView.rowHeight = CGFloat(Double((UIScreen.mainScreen().bounds.height - 180) / 2.2))
            
            if i == 0 {
                
            getUrlList(i)
            
            travelView.registerNibOf(CYTravelsViewCell)
            
//            travelView.rowHeight = CGFloat(Double((UIScreen.mainScreen().bounds.height - 108) / 2.5))
 
            views.append(travelView)
  
            scrollView.addSubview(travelView)

            } else {
                
                getUrlList(i)
                
                travelView.registerNibOf(CYSpecialTopicViewCell)
                
//                travelView.rowHeight = CGFloat(Double((UIScreen.mainScreen().bounds.height - 180) / 2.5))
                
                views.append(travelView)
                
                scrollView.addSubview(travelView)
                
            }
                        
        }
        
        self.view.addSubview(scrollView)
    }
    
    func refresh() {
        let index = Int(control.index)
        curPage = 1
        getUrlList(index)
        
    }
    
    func loadMore() {
        
        let index = Int(control.index)
        curPage += 1
        getUrlList(index)
    
    }
    
    func getUrlList(index: Int) {
        
        if index == 0 {
            
//            dispatch_async(dispatch_get_global_queue(0, 0)) {
//            
//            let string = String(format: travels, self.curPage)
//            
//            let url = NSURL(string: string)
// 
//            let cellData = NSData.init(contentsOfURL: url!)
//            
//            let cellInfo = try! NSJSONSerialization.JSONObjectWithData(cellData!, options: NSJSONReadingOptions.MutableContainers)
//          
//            let a = NSArray.yy_modelArrayWithClass(YJMainPageModel.self, json: cellInfo)!
//            
//            self.cellModels.append(a)
//            
//            dispatch_async(dispatch_get_main_queue(), {
////                print("123",self.cellModels.count)
//                
//            self.views.first!.reloadData()
//            
//            self.views.last!.reloadData()
//                
//                })
//            }
            
            download(travels, model: YJMainPageModel.self, curPage_1: curPage, index: 0)
            
        } else {
//            dispatch_async(dispatch_get_global_queue(0, 0), { 
//                
//                let string = String(format: speciaTop, self.curPage)
//                
//                let url = NSURL(string: string)
//                
//                Alamofire.request(.GET, url!).responseJSON { response in
//                    
//                    guard let JSON = response.result.value else { return }
//                    
//                    self.cellModels_1 = NSArray.yy_modelArrayWithClass(YJSpecialTopModel.self, json: JSON)!
//                    
//                    dispatch_async(dispatch_get_main_queue(), { 
//                        
//                        self.views.first?.reloadData()
//                        
//                        self.views.last?.reloadData()
//                        
//                    })
//                    
//                }
//                
//            })
            
            download(speciaTop, model: YJSpecialTopModel.self, curPage_1: self.curPage, index: 1)
       
        }

    }
    
    func download(format: String, model: AnyClass, curPage_1: Int, index: Int) {
        
            let string = String(format: format, curPage_1)
            
            let url = NSURL(string: string)
        
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
            Alamofire.request(.GET, url!).responseJSON { response in
       
                guard let JSON = response.result.value else { return }
                
                var b = NSArray.yy_modelArrayWithClass(model, json: JSON)!
                
                if index == 0 {
                    if self.curPage == 1 {
                        self.cellModels = b
                    }else {
                        self.cellModels.appendContentsOf(b)
                    }
                    
                }else {
                    if self.curPage == 1 {
                        b.removeFirst()
                        self.cellModels_1 = b
                        
                    }else {
                        self.cellModels_1.appendContentsOf(b)
                    }
                }
                
//                dispatch_async(dispatch_get_main_queue(), {
                    self.views[index].mj_header.endRefreshing()
                    self.views[index].mj_footer.endRefreshing()
                    self.views[index].reloadData()
        
//                })
                
            }
            MBProgressHUD.hideHUDForView(self.view, animated: true)
    }

    func betterSegmentedController() {
       
        control = BetterSegmentedControl(frame: CGRect(x: (view.bounds.maxX * 0.03), y: 74.0, width: (view.bounds.width * 0.94), height: 35.0), titles: ["游记", "专题"], index: 0, backgroundColor: UIColor(red:0.851, green:0.851, blue:0.851, alpha:1.0), titleColor: UIColor.blackColor(), indicatorViewBackgroundColor: UIColor(red:0.9882, green:0.9882, blue:0.9882, alpha:1.0), selectedTitleColor: UIColor ( red: 0.9024, green: 0.7138, blue: 0.457, alpha: 1.0 ))
        
        control.cornerRadius = 5
        control.titleFont = UIFont(name: "HelveticaNeue", size: 14.0)!
        control.selectedTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 14.0)!
        control.addTarget(self, action: #selector(controlValueChanged(_:)), forControlEvents: .ValueChanged)
        
        view.addSubview(control)
    }
    
    func controlValueChanged(control: UIControl) {
        
        let realControl = control as! BetterSegmentedControl
        
        let index = CGFloat.init(realControl.index)
        
        UIView.animateWithDuration(0.2) {
            self.scrollView.contentOffset = CGPointMake(index*self.pageWidth, 0)
        }
    }
    override func viewWillAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(nil,
                                                                    forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension CYMainPageViewController {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if scrollView != views.first && scrollView != views.last{
            let index = scrollView.contentOffset.x/pageWidth
            if index == 0 || index == 1 {
                try! control.setIndex(UInt(index))
            }
        }
    }
}

extension CYMainPageViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
        if tableView == views.first {
            
            return cellModels.count
            
        }else{
            
            return cellModels_1.count
            
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == views.first {
        
            let cell : CYTravelsViewCell = tableView.dequeueReusableCell()
            
            cell.selectionStyle = .None
            
            let model = cellModels[indexPath.row]
            
            cell.configModel(model as! YJMainPageModel)
            
            return cell
            
        }else{
    
            let cell : CYSpecialTopicViewCell = tableView.dequeueReusableCell()
            
            cell.selectionStyle = .None
            
            let model = cellModels_1[indexPath.row]
//            print(model)
            
            cell.SpeciaConfigModel(model as! YJSpecialTopModel)
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        if tableView == views.first {
            
        let vc = MainTravelViewController_2()
            
        let model = cellModels[indexPath.row] as! YJMainPageModel
        
        vc.id = Int(model.id!)
        
        vc.string_bakcImg = model.front_cover_photo_url!
            
        vc.headImage = model.user.image!
            
        vc.headTitle = model.name!
            
        vc.startDate = model.start_date!
            
        vc.days = model.days!
            
        vc.photoCount = model.photos_count!
        
        vc.hidesBottomBarWhenPushed = true
        
//        self.presentViewController(vc, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
            
        }else {
            
            let model = cellModels_1[indexPath.row] as! YJSpecialTopModel
            
            let vc = MainTravelViewController_3()
  
            vc.urlString = "http://chanyouji.com/api/articles/"+"\(model.id!)"+".json"
            
            vc.img_url = model.image_url!
           
            vc.name = model.name
            
            vc.title_1 = model.title
            
            vc.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
     
    }

}