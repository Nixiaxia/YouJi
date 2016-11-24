//
//  CYTabBarController.swift
//  YouJi
//
//  Created by 逆夏夏 on 16/10/26.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit

class CYTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureViewController()
        
    }
    
    func configureViewController() {
        let vcInfos = [
        [
            "title": "Day1",
            "tabBarTitle": "游记",
            "image": "youji",
            "class": "YouJi.CYMainPageViewController",
            ],
        [
            "title": "Day1攻略",
            "tabBarTitle": "攻略",
            "image": "gonglue",
            "class": "YouJi.CYStrategyViewController",
            ],
//        [
//            "title": "旅行工具箱",
//            "tabBarTitle": "工具箱",
//            "image": "gongjuxiang",
//            "class": "YouJi.TestViewController_1",
//            ],
//        [
//            "title": "我的旅行",
//            "tabBarTitle": "我的",
//            "image": "wode",
//            "class": "YouJi.TestViewController_1",
//            ],
//        [
//            "title": "离线内容",
//            "tabBarTitle": "离线",
//            "image": "lixian",
//            "class": "YouJi.TestViewController_1",
//            ],
        ]
        
        var vcArr: [UINavigationController] = []
        
        for vcInfo in vcInfos {
            let vc = (NSClassFromString(vcInfo["class"]!) as! UIViewController.Type).init()
            
            vc.navigationItem.title = vcInfo["title"]
            
            
            let navVc = UINavigationController.init(rootViewController: vc)
            navVc.tabBarItem.title = vcInfo["tabBarTitle"]
            vcArr.append(navVc)
        }
        
        self.tabBar.tintColor = UIColor ( red: 0.9024, green: 0.7138, blue: 0.457, alpha: 1.0 )
        
        self.viewControllers = vcArr
        
        var i = 0
        //设置tabBar按钮图片
        for tabBarItem in self.tabBar.items! {
            tabBarItem.image = UIImage.init(named: vcInfos[i]["image"]!)
            i = i + 1
        }
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
