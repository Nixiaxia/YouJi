//
//  CYTravelsViewCell.swift
//  YouJi
//
//  Created by 逆夏夏 on 16/10/29.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit
import YYWebImage
import SnapKit

class CYTravelsViewCell: UITableViewCell {

    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var start_date: UILabel!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var photos_count: UILabel!
    @IBOutlet weak var front_cover_photo_url: UIImageView!
    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        gradientLayer.locations = [0.0, 0.4]

        gradientLayer.colors = [UIColor ( red: 0.3477, green: 0.3509, blue: 0.2693, alpha: 0.4 ).CGColor, UIColor.clearColor().CGColor]
        self.front_cover_photo_url.layer.addSublayer(gradientLayer)
   
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.contentView.bounds     
    }

    func configModel(model: YJMainPageModel) {
//        self.contentView.backgroundColor = UIColor.whiteColor()
//        self.contentView.clipsToBounds = true
        
        
        let url = NSURL(string: model.front_cover_photo_url!)
        
        
        front_cover_photo_url.yy_setImageWithURL(url, placeholder: nil)
        
        front_cover_photo_url.contentMode = UIViewContentMode.ScaleAspectFill
        
        front_cover_photo_url.layer.borderColor = UIColor.whiteColor().CGColor
       
        //裁剪
        front_cover_photo_url.layer.masksToBounds = true
        
        front_cover_photo_url.layer.cornerRadius = 5
        
        //裁剪 
//        front_cover_photo_url.clipsToBounds = true
        
        let headUrl = NSURL(string: model.user.image!)
        headImage.yy_imageURL = headUrl
        
        headImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        headImage.layer.borderWidth = 2
        
        if model.start_date != nil {
            self.start_date.text = "\(model.start_date!)"
        }
        
        self.days.text = "\(model.days!)"
        
        self.photos_count.text = "\(model.photos_count!)"
        
        self.titleName.text = "\(model.name!)"
    
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
