//
//  MapViewController.swift
//  YouJi
//
//  Created by 逆夏夏 on 2016/11/19.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit

class MapViewController: ViewController {

    var mapView: BMKMapView?
    
    var latNum: Double?
    var lngNum: Double?
    var title_1: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "地点"
        
        mapView = BMKMapView.init(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        
        leftNavigationBar()
        
        self.view.addSubview(mapView!)
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

    
    override func viewDidAppear(animated: Bool) {
        //地图中心点坐标
        let center = CLLocationCoordinate2D(latitude: latNum!, longitude: lngNum!)
        //设置地图的显示范围（越小越精确）
        let span = BMKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        //设置地图最终显示区域
        let region = BMKCoordinateRegion(center: center, span: span)
        mapView?.region = region
        
        // 添加一个标记点(PointAnnotation）
        let annotation =  BMKPointAnnotation()
        var coor = CLLocationCoordinate2D()
        coor.latitude = latNum!
        coor.longitude = lngNum!
        annotation.coordinate = coor
        annotation.title = title_1
        mapView!.addAnnotation(annotation)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mapView?.viewWillAppear()
        mapView?.delegate = nil
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        mapView?.viewWillDisappear()
        mapView?.delegate = nil
     
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
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
