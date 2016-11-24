//
//  SpecialTableViewCell.swift
//  YouJi
//
//  Created by 逆夏夏 on 2016/11/22.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit
import YYWebImage
import IDMPhotoBrowser

class SpecialTableViewCell: UITableViewCell {

//    @IBOutlet weak var headTitle: UILabel!
//    @IBOutlet weak var headTitleHight: NSLayoutConstraint!
//    @IBOutlet weak var centerImage: UIImageView!
//    @IBOutlet weak var centerImageHight: NSLayoutConstraint!
//    @IBOutlet weak var bottomTitle: UILabel!
//    @IBOutlet weak var bottomTitleHight: NSLayoutConstraint!
    
    @IBOutlet weak var headTitle: UILabel!    
    @IBOutlet weak var headTitleHight: NSLayoutConstraint!
    @IBOutlet weak var centerImage: UIImageView!
    @IBOutlet weak var centerImageHight: NSLayoutConstraint!
    @IBOutlet weak var bottomTitle: UILabel!
    @IBOutlet weak var bottomTitleHight: NSLayoutConstraint!
    
    var url: NSURL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configWithModel(model:Article_Sections){
        
        url = NSURL.init(string: model.image_url!)
        
        if model.title == nil {
            self.headTitle.text = ""
            self.headTitleHight.constant = 0
        }else {
            self.headTitle.text = model.title
        }
        
        if url == nil {
            self.centerImageHight.constant = 0
        }else {
            self.centerImage.yy_setImageWithURL(url, placeholder: nil)
            self.centerImageHight.constant = CGFloat((model.image_height)/4)
            self.centerImage.layer.masksToBounds = true
            self.centerImage.contentMode = UIViewContentMode.ScaleAspectFill
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(TripsTableViewCell.tapClick))
            
            self.centerImage.userInteractionEnabled = true
            self.centerImage.addGestureRecognizer(tap)
            
        }
        
        if model.desc == nil {
            
            self.bottomTitle.text = ""
            self.bottomTitleHight.constant = 0
            
        }else {
            
            self.bottomTitle.numberOfLines = 0
            self.bottomTitle.lineBreakMode = NSLineBreakMode.ByCharWrapping
            self.bottomTitle.font = UIFont.systemFontOfSize(13)
            
            var bottomStr = model.desc!
            for (key, value) in model.description_user_ids! {
                bottomStr = bottomStr.stringByReplacingOccurrencesOfString("\(key)", withString: value)
            }
            
            self.bottomTitle.text = bottomStr
            
        }
   
    }
    
    func tapClick() {
        
        let photo = IDMPhoto.init(URL: url!)
        if self.bottomTitle != nil {
            photo.caption = self.bottomTitle.text
        }
        
        var photos = [AnyObject]()
        photos.append(photo)
        let photoBrowser = IDMPhotoBrowser.init(photos: photos)
        
        photoBrowser.displayToolbar = true
        photoBrowser.displayCounterLabel = true
        
        //        photoBrowser.delegate = self
        
        self.jk_viewController.presentViewController(photoBrowser, animated: true, completion: nil)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
