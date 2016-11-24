//
//  CYSpecialTopicViewCell.swift
//  YouJi
//
//  Created by 逆夏夏 on 16/10/29.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit
import YYWebImage

class CYSpecialTopicViewCell: UITableViewCell {
    
    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        gradientLayer.frame = image_url.frame
        
        gradientLayer.locations = [0.0, 0.75]
        
        gradientLayer.colors = [UIColor.clearColor().CGColor, UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4 ).CGColor]
        
        self.image_url.layer.addSublayer(gradientLayer)
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = self.contentView.bounds
        
    }

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image_url: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func SpeciaConfigModel(model: YJSpecialTopModel) {
        
        let url = NSURL(string: model.image_url!)
        image_url.yy_setImageWithURL(url, placeholder: nil)
        
        image_url.contentMode = UIViewContentMode.ScaleAspectFill
        
        image_url.layer.cornerRadius = 5
        
        image_url.layer.masksToBounds = true
        
        image_url.layer.borderColor = UIColor.whiteColor().CGColor
        
//        image_url.layer.borderWidth = 5
        
        self.title.text = "\(model.title!)"
        
        self.name.text = "\(model.name!)"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
