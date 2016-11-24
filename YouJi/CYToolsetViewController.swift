//
//  CYToolsetViewController.swift
//  YouJi
//
//  Created by 逆夏夏 on 16/11/2.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit

class CYToolsetViewController: ViewController {

    @IBAction func openAction(sender: AnyObject) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor ( red: 0.9334, green: 0.9334, blue: 0.9334, alpha: 1.0 )
        
        openAction.layer.cornerRadius = 5
    }

    @IBOutlet weak var openAction: UIButton!
    
    
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
