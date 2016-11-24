//
//  GuideViewController.swift
//  YouJi
//
//  Created by 逆夏夏 on 16/11/9.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit
import Alamofire

class GuideViewController: ViewController {
    
    var string: String?
    var navTilte: String?
    
    var dataSource: [AnyObject] = []
    var vc = UITableView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height), style: .Plain)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor ( red: 0.9334, green: 0.9334, blue: 0.9334, alpha: 1.0 )
        print(navTilte!)
        
        self.title = navTilte!
        
        createTableView()
        
        leftNavigationBar()
        
        donwload()
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
    
    func createTableView() {
        
        vc.separatorStyle = .None
        vc.showsHorizontalScrollIndicator = false
        vc.showsVerticalScrollIndicator = false
        vc.rowHeight = CGFloat(Double(UIScreen.mainScreen().bounds.height - 65)/2)
        
        vc.delegate = self
        vc.dataSource = self
        vc.registerClassOf(GudeTableViewCell_1)
  
        self.view.addSubview(vc)
        
    }
    
    func donwload() {
        
        let url = NSURL(string: (self.string)!)
//        print(url!)
        Alamofire.request(.GET, url!).responseJSON { (response) in
            guard let JSON = response.result.value else {return}
            
            let a = NSArray.yy_modelArrayWithClass(travelDetailModel.self, json: JSON)
            
//            print(a)
            
            self.dataSource = a!
            
            dispatch_async(dispatch_get_main_queue(), { 
                self.vc.reloadData()
            })
            
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

extension GuideViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        print(dataSource.count)
        
        return dataSource.count
        
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: GudeTableViewCell_1 = tableView.dequeueReusableCell()
        
        let model = dataSource[indexPath.row]
        
        cell.configModel(model as! travelDetailModel)
        
        cell.selectionStyle = .None
        
        return cell
        
    }
    
}
