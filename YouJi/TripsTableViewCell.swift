//
//  TripsTableViewCell.swift
//  YouJi
//
//  Created by 逆夏夏 on 16/11/16.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit
import IDMPhotoBrowser
import SDCycleScrollView

class TripsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftButton: UIButton!

    @IBOutlet weak var leftButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var centerImageHeight: NSLayoutConstraint!
    @IBOutlet weak var headImageHeight: NSLayoutConstraint!
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var headTitle: UILabel!
    @IBOutlet weak var topContent: UILabel!
    @IBOutlet weak var centerImage: UIImageView!
    @IBOutlet weak var bottonContent: UILabel!
    
    var titleName: String?
    
    var a: Double?
    var b: Double?
    var title: String?
    var url: NSURL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configWithModel(nodesmodel: nodes_Model, notesmodel:notes_Model, isFirst: Bool) {
        
        if nodesmodel.entry_name == nil {
            self.headTitle.text = ""
            
            self.headImage.image = UIImage()
            self.headImageHeight.constant = 0
            
            self.leftButton.setImage(UIImage(), forState: .Normal)
            self.leftButton.setTitle("", forState: .Normal)
            self.leftButtonHeight.constant = 30
            
        }else {
            
            if isFirst {
                self.headTitle.text = nodesmodel.entry_name!
                self.headImage.image = UIImage.init(named: "NodeIconAttraction_ipad96")
                self.headImageHeight.constant = 60
                
            }else {
                
                self.headTitle.text = ""
                self.headImage.image = UIImage()
                self.headImageHeight.constant = 0
                
            }
//            
//            self.headTitle.text = nodesmodel.entry_name!
//            self.headImage.image = UIImage.init(named: "NodeIconAttraction_ipad96")
//            self.headImageHeight.constant = 60
            
            self.leftButton.setImage(UIImage.init(named: "NodeIconCustom96-1")?.imageWithRenderingMode(.AlwaysOriginal) , forState: .Normal)
            self.leftButton.setTitle(nodesmodel.entry_name, forState: .Normal)
            self.leftButton.setTitleColor(UIColor ( red: 0.3212, green: 0.3345, blue: 0.5548, alpha: 1.0 ), forState: .Normal)
            
            leftButton.addTarget(self, action: #selector(TripsTableViewCell.leftButtonAction), forControlEvents: .TouchUpInside)
            
            self.leftButtonHeight.constant = 30
            
            a = Double(nodesmodel.lat!)
            b = Double(nodesmodel.lng!)
            title = nodesmodel.entry_name
         
        }
        
        
        
        if nodesmodel.comment == nil {
            self.topContent.text = ""
        }else {
            self.topContent.numberOfLines = 0
            self.topContent.lineBreakMode = NSLineBreakMode.ByCharWrapping
            self.topContent.font = UIFont.systemFontOfSize(14)
            self.topContent.text = "\(nodesmodel.comment!)"
        }
       
        if notesmodel.desc == nil {
            
            self.bottonContent.text = ""
            
        }else {
            self.bottonContent.numberOfLines = 0
            self.bottonContent.lineBreakMode = NSLineBreakMode.ByCharWrapping
            self.bottonContent.font = UIFont.systemFontOfSize(14)
            self.bottonContent.text = "\(notesmodel.desc!)"
        }
        
        if notesmodel.photo?.url == nil {
            
            self.centerImageHeight.constant = 0
            
        }else {
  
            url = NSURL(string: (notesmodel.photo?.url!)!)
            
            self.centerImage.yy_setImageWithURL(url, placeholder: nil)
            
            self.centerImageHeight.constant = CGFloat((notesmodel.photo?.image_height)!/4)
            
            self.centerImage.contentMode = UIViewContentMode.ScaleAspectFill
            
            self.centerImage.layer.masksToBounds = true
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(TripsTableViewCell.tapClick))
            
            self.centerImage.userInteractionEnabled = true
            self.centerImage.addGestureRecognizer(tap)
            
        }
        
    }
    
    func tapClick() {
        
        let photo = IDMPhoto.init(URL: url!)
        if self.bottonContent != nil {
            photo.caption = self.bottonContent.text
        }
        
        var photos = [AnyObject]()
        photos.append(photo)
        let photoBrowser = IDMPhotoBrowser.init(photos: photos)
        
        photoBrowser.displayToolbar = true
        photoBrowser.displayCounterLabel = true
        
//        photoBrowser.delegate = self
    
        self.jk_viewController.presentViewController(photoBrowser, animated: true, completion: nil)
        
    }
    
    func leftButtonAction() {
        let vc = MapViewController()
        vc.latNum = a
        vc.lngNum = b
        vc.title_1 = title
        self.jk_viewController.navigationController?.pushViewController(vc, animated: true)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
   
}

//extension TripsTableViewCell: IDMPhotoBrowserDelegate {
//    
//    func photoBrowser(photoBrowser: IDMPhotoBrowser!, captionViewForPhotoAtIndex index: UInt) -> IDMCaptionView! {
//        let photo = IDMPhoto.init(URL: url!)
//        photo.caption = "123"
//        
//        return
//    }
//    
//}






