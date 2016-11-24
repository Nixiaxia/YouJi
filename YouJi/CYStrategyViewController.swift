//
//  YZStrategyViewController.swift
//  YouJi
//
//  Created by 逆夏夏 on 16/10/26.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import Alamofire
import MJRefresh

class CYStrategyViewController: ViewController {
    
    //数据源
    var dataSource: [AnyObject] = []
    var dataSource_1: [AnyObject] = []
  
    var curPage: Int = 1
    
//    var cellModel: YJTravelGuideModel!
    
    var pageWidth = UIScreen.mainScreen().bounds.width
    var pageHeight = UIScreen .mainScreen().bounds.height
    
    let scrollView = UIScrollView()
    
    var control: BetterSegmentedControl!
    
    //集合视图
    var collectionViews = [UICollectionView]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createScrollView()
        
        betterSegmentedController()
        
    }
    
    func betterSegmentedController() {
        
        control = BetterSegmentedControl(frame: CGRect(x: (view.bounds.maxX * 0.03), y: 74.0, width: (view.bounds.width * 0.94), height: 35.0), titles: ["国外","国内"], index: 0, backgroundColor: UIColor(red:0.851, green:0.851, blue:0.851, alpha:1.0), titleColor: UIColor.blackColor(), indicatorViewBackgroundColor: UIColor(red:0.9882, green:0.9882, blue:0.9882, alpha:1.0), selectedTitleColor: UIColor ( red: 0.9024, green: 0.7138, blue: 0.457, alpha: 1.0 ))
        
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
    
    func createScrollView() {
        
        //scrollView的初始化
        scrollView.frame = CGRectMake(0, 74+44, pageWidth, pageHeight)
        
        scrollView.contentSize = CGSizeMake(pageWidth*CGFloat(2), 0)
    
        scrollView.backgroundColor = UIColor.whiteColor()
        
        scrollView.pagingEnabled = true
        
        //关闭回弹
        scrollView.bounces = false
        
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.scrollsToTop = false
        
        scrollView.delegate = self
        
        //添加子页面
        for i in 0..<2 {
            
            let layout = UICollectionViewFlowLayout()
            //设置滚动方向
            layout.scrollDirection = .Vertical
            //页眉大小
            layout.headerReferenceSize = CGSize(width: view.bounds.width, height: 10)
            //设置item大小
            layout.itemSize = CGSize(width: CGFloat((view.bounds.width - 25)/2), height: CGFloat((view.bounds.size.height - 165)/2.2))

            //设置最小行间距
            layout.minimumLineSpacing = 5
            //设置最小列间距
            layout.minimumInteritemSpacing = 5
            //设置边距
            layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10)
            
            self.automaticallyAdjustsScrollViewInsets = false
            
            let collectionView = UICollectionView(frame: CGRectMake(CGFloat((view.bounds.size.width)*CGFloat(i)), 0, view.bounds.size.width, CGFloat(view.bounds.size.height - 165)), collectionViewLayout: layout)
            
//            collectionView.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(10)), green: CGFloat(arc4random_uniform(10)), blue: CGFloat(arc4random_uniform(10)), alpha: 1)
            
            collectionView.backgroundColor = UIColor.whiteColor()
            
            collectionView.showsVerticalScrollIndicator = false
            
            collectionView.showsHorizontalScrollIndicator = false

            //设置代理
            collectionView.dataSource = self
            
            collectionView.delegate = self
            
//            collectionView.registerClass(TravelGuideViewCell.self, forCellWithReuseIdentifier: "Travel")
            
            
            
            if i == 0 {

                
//                collectionView.registerNib(UINib.init(nibName: "TravelGuideViewCell", bundle: nil), forCellWithReuseIdentifier: "item1")
                
                collectionView.registerNibOf(TravelGuideViewCell)
                
//                scrollView.addSubview(collectionView)
                
            }else{
                
                collectionView.registerNib(UINib.init(nibName: "TravelGuideViewCell", bundle: nil), forCellWithReuseIdentifier: "item2")
                            
//                scrollView.addSubview(collectionView)
                
            }
            
            //注册页眉的类
//            collectionView.registerClass(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
            
            
            collectionView.registerNib(UINib.init(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
       
            collectionViews.append(collectionView)
            scrollView.addSubview(collectionView)
        }
        
        download()
        self.view.addSubview(scrollView)
    
    }
    
    func download() {
        
        dispatch_async(dispatch_get_global_queue(0, 0), {
            
            let url = NSURL(string: travelGuide)
            
            Alamofire.request(.GET, url!).responseJSON(completionHandler: { (response) in
                guard let JSON = response.result.value else {return}
                
                
                let a = NSArray.yy_modelArrayWithClass(YJTravelGuideModel.self, json: JSON)
                
//                if index == 0 {
                
                    for dict in a! {
                        if dict.category == "1" || dict.category == "2" || dict.category == "3" {
                           
                            self.dataSource.append(dict)
//                            print(self.dataSource.count)
                        }
                    }
//                }else if index == 1 {
                
                    for dict in a! {
                        if dict.category == "99" || dict.category == "999" {
//                            print(dict)
                            self.dataSource_1.append(dict)
//                            print(self.dataSource_1.count)
                        }
                    }
//                }
                dispatch_async(dispatch_get_main_queue(), {
        
                    self.collectionViews[0].reloadData()
                    self.collectionViews[1].reloadData()
                    
                })
                
            })
            
        })
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension CYStrategyViewController {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if collectionViews != collectionViews.first && scrollView != collectionViews.last {
            let index = scrollView.contentOffset.x/pageWidth
            if index == 0 || index == 1 {
                     try! control.setIndex(UInt(index))
            }
            
        }
        
    }
    
}

extension CYStrategyViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //分区个数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        if collectionView == collectionViews.first {
//            print(dataSource.count)
            return dataSource.count
            
        }else {
//            print(dataSource_1.count)
            return dataSource_1.count
            
        }
   
    }
   
    //分区的item个数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
        if collectionView == collectionViews.first {
            
            return  (dataSource[section] as! YJTravelGuideModel).destinations!.count
            
        }else {
            
            return (dataSource_1[section] as! YJTravelGuideModel).destinations!.count
            
        }
    }
    
    //返回item的内容
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
       
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Travel", forIndexPath: indexPath) as! TravelGuideViewCell
        
        if collectionView == collectionViews.first {
            
            let cate = (dataSource[indexPath.section]) as! YJTravelGuideModel
//            //取出数据
            let model = cate.destinations![indexPath.item]

//            let cell: TravelGuideViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("item1", forIndexPath: indexPath) as! TravelGuideViewCell
            
            let cell: TravelGuideViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
//
////            print((dataSource[indexPath.section]).destinations![indexPath.row])
//            
//            //print(travel)
//            
            cell.travelGuide(model)
            
            return cell

        }else {
            
            let cate_1 = dataSource_1[indexPath.section] as! YJTravelGuideModel
            
            let model = cate_1.destinations![indexPath.item]
            
            let cell: TravelGuideViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("item2", forIndexPath: indexPath) as! TravelGuideViewCell
          
            
            //        print((dataSource[indexPath.section]).tmpDes![indexPath.row])
            
            //        print(travel)
            
            cell.travelGuide(model)
            
            return cell
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var view: HeaderCollectionReusableView?
        
        if collectionView == collectionViews.first {
            
            let model = dataSource[indexPath.section] as! YJTravelGuideModel
            
            view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", forIndexPath: indexPath) as? HeaderCollectionReusableView
        
        
            view?.travelArea(model)
            
        }else {
            
            let model = dataSource_1[indexPath.section] as! YJTravelGuideModel
            
            view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", forIndexPath: indexPath) as? HeaderCollectionReusableView
            
            
            view?.travelArea(model)
            
        }
       
        return view!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSizeMake(UIScreen.mainScreen().bounds.width, 30)
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let svc = GuideViewController()
        
        if collectionView == collectionViews.first {
            
            let cate = dataSource[indexPath.section] as! YJTravelGuideModel
            
            let model = cate.destinations![indexPath.item]
            
            svc.string = "http://chanyouji.com/api/destinations/"+"\(model.id!)"+".json?page=1"
            
//            print("\(svc.string)")
            
            svc.navTilte = model.name_zh_cn
            
            svc.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(svc, animated: true)
            
        }else {
            
            let cate = dataSource_1[indexPath.section] as! YJTravelGuideModel
            
            let model = cate.destinations![indexPath.item]
            
            svc.string = "http://chanyouji.com/api/destinations/"+"\(model.id!)"+".json?page=1"
            
            svc.navTilte = model.name_zh_cn
            
//            print(svc.navTilte)
            
//            print("\(svc.string)")
            svc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(svc, animated: true)
          
        }
        
    }
    
}
