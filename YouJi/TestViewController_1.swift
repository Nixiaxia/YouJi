//
//  TestViewController_1.swift
//  YouJi
//
//  Created by 逆夏夏 on 2016/11/20.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit

class TestViewController_1: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor ( red: 0.9334, green: 0.9334, blue: 0.9334, alpha: 1.0 )
        
        leftNavigationBar()
    }
    
    func leftNavigationBar() {
        
        let leftBarBtn = UIBarButtonItem.init(title: "", style: .Plain, target: self, action: #selector(SettingViewController.backToPrevious))
        leftBarBtn.image = UIImage.init(named: "nav_back_icon_ipad")?.imageWithRenderingMode(.AlwaysOriginal)
        
        //用于消除左边空隙
        let spacer = UIBarButtonItem.init(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        spacer.width = -10
        
        self.navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
        
    }
    
    //返回按钮点击响应
    func backToPrevious() {
        self.navigationController?.popViewControllerAnimated(true)
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
