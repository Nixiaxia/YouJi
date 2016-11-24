//
//  SettingViewController.swift
//  YouJi
//
//  Created by 逆夏夏 on 16/11/8.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit
import MessageUI

class SettingViewController: UIViewController {
    
    var timer = NSTimer()
    
    let descArray = [
        [
         ["title": "给我们记提意见",
            "image": "Message"],
         ["title": "去AppStore评价我们",
            "image": "star"],
//         ["title": "连接社交网络",
//            "image": "double-page"],
//         ["title": "消息推送设置",
//            "image": "tuisong"],
         ["title": "清除浏览缓存",
            "image": "delete"]
        ],
//        [
//            [
//                "title": "登录"
//            ]
//        ]
]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        createTableView()
        
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
    
    func createTableView() {
        
        let settingTableView = UITableView.init(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height), style: .Grouped)
        
        settingTableView.showsVerticalScrollIndicator = false
        
        settingTableView.showsHorizontalScrollIndicator = false
        
        settingTableView.registerClassOf(UITableViewCell)
        
        settingTableView.rowHeight = 44
        
        settingTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
//        settingTableView.sectionFooterHeight = 40
        
        settingTableView.delegate = self
        
        settingTableView.dataSource = self
        
        self.view.addSubview(settingTableView)

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

extension SettingViewController: UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate {
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        
        // 设置邮件地址、主题及正文
        mailComposeVC.setToRecipients(["578670108@qq.com"])
        mailComposeVC.setSubject("< 邮件主题 >")
        mailComposeVC.setMessageBody("< 邮件正文 >", isHTML: false)
        
        return mailComposeVC
        
    }
    
    func showSendMailErrorAlert() {
        
        let sendMailErrorAlert = UIAlertController(title: "无法发送邮件", message: "您的设备尚未设置邮箱，请在“邮件”应用中设置后再尝试发送。", preferredStyle: .Alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "确定", style: .Default) { _ in })
        self.presentViewController(sendMailErrorAlert, animated: true){}
        
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        print(descArray.count)
        return descArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(descArray[section].count)
        return descArray[section].count
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell()
        
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        
        cell.textLabel?.textColor = UIColor ( red: 0.3736, green: 0.3736, blue: 0.3736, alpha: 1.0 )
        
        
        
        if indexPath.section == 0 {
            cell.textLabel?.text = descArray[indexPath.section][indexPath.row]["title"]
            cell.imageView?.image = UIImage.init(named: descArray[indexPath.section][indexPath.row]["image"]!)?.imageWithRenderingMode(.AlwaysOriginal)
            
        }else {
            cell.textLabel?.text = descArray[indexPath.section][indexPath.row]["title"]
            cell.textLabel?.textAlignment = .Center
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
//                self.navigationController?.popViewControllerAnimated(true)
                    print("意见反馈")
                    
                    if MFMailComposeViewController.canSendMail() {
                        // 注意这个实例要写在 if block 里，否则无法发送邮件时会出现两次提示弹窗（一次是系统的）
                        let mailComposeViewController = configuredMailComposeViewController()
                        self.presentViewController(mailComposeViewController, animated: true, completion: nil)
                    } else {
                        self.showSendMailErrorAlert()
                    }
            }else if indexPath.row == 1 {
                
                let alertController = UIAlertController(title: "觉得好用的话，给我个评价吧！",
                                                        message: nil, preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "暂不评价", style: .Cancel, handler: nil)
                let okAction = UIAlertAction(title: "好的", style: .Default,
                                             handler: {
                                                action in
                                                self.gotoAppStore()
                })
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
//                let urlString = "itms-apps://itunes.apple.com/app/id1172659803"
//                    let url = NSURL(string: urlString)
//                    UIApplication.sharedApplication().openURL(url!)
                
            }
//            else if indexPath.row == 2 {
//                
//                let alertController = UIAlertController.init(title: "抱歉，此功能暂未开放～后续将会添加", message: nil, preferredStyle: .ActionSheet)
//                timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(SettingViewController.tickDown), userInfo: nil, repeats: false)
//                //显示提示框
//                self.presentViewController(alertController, animated: true, completion: nil)
//                //两秒后自动消失
////                dispatch_after(DISPATCH_TIME_NOW + 2, dispatch_get_main_queue(), {
////                    self.presentedViewController?.dismissViewControllerAnimated(false, completion: nil)
////                })
//                
//                
//            }
//            else if indexPath.row == 3 {
//                
//                let alertController = UIAlertController.init(title: "抱歉，此功能暂未开放～后续将会添加", message: nil, preferredStyle: .ActionSheet)
//                //显示提示框
//                self.presentViewController(alertController, animated: true, completion: nil)
//                //两秒后自动消失
////                dispatch_after(DISPATCH_TIME_NOW + 2, dispatch_get_main_queue(), {
////                    self.presentedViewController?.dismissViewControllerAnimated(false, completion: nil)
////                })
//                
//                timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(SettingViewController.tickDown), userInfo: nil, repeats: false)
//                
//            }
            else if indexPath.row == 2 {
                let alertController = UIAlertController(title: "保存或删除数据", message: "删除数据将不可恢复",preferredStyle: .ActionSheet)
                let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
                let deleteAction = UIAlertAction(title: "删除", style: .Destructive, handler: nil)
                let archiveAction = UIAlertAction(title: "保存", style: .Default, handler: nil)
                alertController.addAction(cancelAction)
                alertController.addAction(deleteAction)
                alertController.addAction(archiveAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
      
        }else {
            
            self.navigationController?.pushViewController(TestViewController_1(), animated: true)
//            self.navigationController?.popViewControllerAnimated(true)
            
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("取消发送")
        case MFMailComposeResultSent.rawValue:
            print("发送成功")
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func tickDown() {
        self.presentedViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
    
    
    func gotoAppStore() {
        let urlString = "itms-apps://itunes.apple.com/app/id1172659803"
        let url = NSURL(string: urlString)
        UIApplication.sharedApplication().openURL(url!)
    }
    
}


