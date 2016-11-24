//
//  ViewController.swift
//  YouJi
//
//  Created by 逆夏夏 on 16/10/26.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit
import YYModel

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.navigationController?.navigationBar.barTintColor = UIColor ( red: 0.9024, green: 0.7138, blue: 0.457, alpha: 1.0 )
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

