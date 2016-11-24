//
//  TravelGuideViewCell.swift
//  YouJi
//
//  Created by 逆夏夏 on 16/11/3.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit
import YYWebImage

class TravelGuideViewCell: UICollectionViewCell {

    @IBOutlet weak var url_Image: UIImageView!
   
    @IBOutlet weak var zh_cn_Name: UILabel!
    
    @IBOutlet weak var en_Name: UILabel!
  
    @IBOutlet weak var count_Poi: UILabel!
    
    let en_Name_1 = UILabel()
    
    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        en_Name.font = UIFont.init(name: "Heiti J", size: 15)
        
        gradientLayer.locations = [0.0, 0.3]
        
        gradientLayer.colors = [UIColor ( red: 0.3477, green: 0.3509, blue: 0.2693, alpha: 0.4 ).CGColor, UIColor.clearColor().CGColor]
        
        self.url_Image.layer.addSublayer(gradientLayer)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = self.contentView.bounds
    }
    
    func travelGuide(model: detailModel){
        
        if model.image_url != nil {
            
            url_Image.yy_setImageWithURL(NSURL(string: model.image_url!), placeholder: nil)
            
        url_Image.contentMode = UIViewContentMode.ScaleAspectFill
            
        url_Image.layer.cornerRadius = 5
            
        url_Image.clipsToBounds = true
        
        }
 
        if model.name_en != nil {
            en_Name_1.text = model.name_en!
            en_Name.text = en_Name_1.text?.uppercaseString
        }
        
        if model.name_zh_cn != nil {
            zh_cn_Name.text = model.name_zh_cn!
        }
        
        if model.poi_count != nil {
            count_Poi.backgroundColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3 )
            count_Poi.layer.cornerRadius = 7
            count_Poi.layer.masksToBounds = true
            count_Poi.text = "旅行地 \(model.poi_count!)"
        }
        
        
    }

}
