//
//  GuideTableViewCell_1.swift
//  YouJi
//
//  Created by 逆夏夏 on 16/11/10.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit

class GudeTableViewCell_1: UITableViewCell {
    
    var guideButton = UIButton()
    var travelButton = UIButton()
    var routeButton = UIButton()
    var specialButton = UIButton()
    
    var selfView = UIView()
    var image_url = UIImageView()
    var name_en = UILabel()
    var name_zh_cn = UILabel()
    let gradientLayer = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = self.contentView.bounds
        
//        selfView.frame = CGRectMake(0, 0, self.contentView.frame.size.width-12, self.contentView.frame.size.height-6)
        
 
    }
    
    func configModel(model: travelDetailModel) {
        
        gradientLayer.locations = [0.0, 0.4]
        gradientLayer.colors = [UIColor ( red: 0.3477, green: 0.3509, blue: 0.2693, alpha: 0.4 ).CGColor, UIColor.clearColor().CGColor]
        
        self.image_url.layer.addSublayer(gradientLayer)
        
        selfView.backgroundColor = UIColor ( red: 0.9146, green: 0.9146, blue: 0.9146, alpha: 1.0 )
        
        selfView.frame = CGRectMake(0, 0, CGFloat((self.contentView.bounds.width)-12), CGFloat((self.contentView.bounds.height)-8))
        
        let width_1 = (selfView.bounds.size.width - 240)/3
        
        guideButton.frame = CGRectMake(0, 0, 60, 60)
        guideButton.setImage(UIImage.init(named: "dengpao"), forState: .Normal)
        guideButton.setTitle("攻略", forState: .Normal)
        guideButton.titleLabel?.font = UIFont.systemFontOfSize(11)
        guideButton.setTitleColor(UIColor ( red: 0.2471, green: 0.2471, blue: 0.2471, alpha: 1.0 ), forState: .Normal)
        guideButton.imageEdgeInsets = UIEdgeInsetsMake(0, 11, 10, 0)
        guideButton.titleEdgeInsets = UIEdgeInsetsMake(40, -20, 0, 12)
        
        travelButton.frame = CGRectMake(0, 0, 60, 60)
        travelButton.setImage(UIImage.init(named: "xianlu"), forState: .Normal)
        travelButton.setTitle("行程", forState: .Normal)
        travelButton.titleLabel?.font = UIFont.systemFontOfSize(11)
        travelButton.setTitleColor(UIColor ( red: 0.2471, green: 0.2471, blue: 0.2471, alpha: 1.0 ), forState: .Normal)
        travelButton.imageEdgeInsets = UIEdgeInsetsMake(0, 11, 10, 0)
        travelButton.titleEdgeInsets = UIEdgeInsetsMake(40, -20, 0, 12)
        
        routeButton.frame = CGRectMake(0, 0, 60, 60)
        routeButton.setImage(UIImage.init(named: "lvxing"), forState: .Normal)
        routeButton.setTitle("旅行地", forState: .Normal)
        routeButton.titleLabel?.font = UIFont.systemFontOfSize(11)
        routeButton.setTitleColor(UIColor ( red: 0.2471, green: 0.2471, blue: 0.2471, alpha: 1.0 ), forState: .Normal)
        routeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 11, 10, 0)
        routeButton.titleEdgeInsets = UIEdgeInsetsMake(40, -25, 0, 8)
        
        specialButton.frame = CGRectMake(0, 0, 60, 60)
        specialButton.setImage(UIImage.init(named: "zhuanti"), forState: .Normal)
        specialButton.setTitle("专题", forState: .Normal)
        specialButton.titleLabel?.font = UIFont.systemFontOfSize(11)
        specialButton.setTitleColor(UIColor ( red: 0.2471, green: 0.2471, blue: 0.2471, alpha: 1.0 ), forState: .Normal)
        specialButton.imageEdgeInsets = UIEdgeInsetsMake(0, 11, 10, 0)
        specialButton.titleEdgeInsets = UIEdgeInsetsMake(40, -20, 0, 12)
      
        self.addSubview(selfView)
        selfView.snp_makeConstraints { (make) in
            make.top.equalTo(4)
            make.bottom.equalTo(-4)
            make.left.equalTo(6)
            make.right.equalTo(-6)
        }
   
        selfView.addSubview(image_url)
        image_url.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(-60)
        }
        
        selfView.layer.cornerRadius = 5
        selfView.clipsToBounds = true

        selfView.addSubview(name_zh_cn)
        name_zh_cn.textColor = UIColor.whiteColor()
        name_zh_cn.snp_makeConstraints { (make) in
            make.top.left.equalTo(10)
        }

        selfView.addSubview(name_en)
        name_en.textColor = UIColor.whiteColor()
        name_en.snp_makeConstraints { (make) in
            make.top.equalTo(name_zh_cn.snp_bottom).offset(1)
            make.left.equalTo(10)
        }

        selfView.addSubview(guideButton)
        guideButton.snp_makeConstraints { (make) in
            make.left.equalTo(width_1)
            make.top.equalTo(image_url.snp_bottom)
            make.bottom.equalTo(-10)
        }

        selfView.addSubview(routeButton)
        routeButton.snp_makeConstraints { (make) in
            make.left.equalTo(guideButton.snp_right).offset(width_1)
            make.top.equalTo(image_url.snp_bottom)
            make.bottom.equalTo(-10)
        }

        selfView.addSubview(travelButton)
        travelButton.snp_makeConstraints { (make) in
            make.left.equalTo(routeButton.snp_right).offset(width_1)
            make.top.equalTo(image_url.snp_bottom)
            make.bottom.equalTo(-10)
        }

        selfView.addSubview(specialButton)
        specialButton.snp_makeConstraints { (make) in
            make.left.equalTo(travelButton.snp_right).offset(width_1)
            make.top.equalTo(image_url.snp_bottom)
            make.bottom.equalTo(-10)
        }
        
        
        if model.image_url != nil {
            
            let url = NSURL(string: model.image_url!)
            
            image_url.yy_setImageWithURL(url, placeholder: nil)
            
            image_url.contentMode = UIViewContentMode.ScaleToFill
            
//            image_url.layer.masksToBounds = true
            
        }
        
        self.name_zh_cn.text = "\(model.name_zh_cn!)概览"
        self.name_en.text = "\(model.name_en!.uppercaseString)"
     
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
