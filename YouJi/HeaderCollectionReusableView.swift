//
//  HeaderCollectionReusableView.swift
//  YouJi
//
//  Created by 逆夏夏 on 16/11/3.
//  Copyright © 2016年 xxp. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    
    @IBOutlet weak var area: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func travelArea(model: YJTravelGuideModel) {
        
        if model.category == "1" {
            self.area.text = "亚洲"
        }else if model.category == "2" {
            self.area.text = "欧洲"
        }else if model.category == "3" {
            self.area.text = "美洲、大洋洲、非洲与南极洲"
        }else if model.category == "99" {
            self.area.text = "港澳台"
        }else {
            self.area.text = "大陆"
        }
        
    }
    
}
