//
//  YJModel.swift
//  YouJi
//
//  Created by 逆夏夏 on 16/10/31.
//  Copyright © 2016年 xxp. All rights reserved.
//

import Foundation

class YJMainPageModel: NSObject {
    
    var id: NSNumber?
    var name: String?
    var photos_count: String?
    var start_date: String?
    var end_date: String?
    var days: String?
    var level: String?
    var views_count: String?
    var comments_count: String?
    var likes_count: String?
    var source: String?
    var front_cover_photo_url: String?
    var featured: String?
    var user: userModel!
    
}

class userModel: NSObject {
    var id: NSNumber?
    var name: String?
    var image: String?
}

class YJSpecialTopModel: NSObject {
    var id: NSNumber?
    var name: String?
    var image_url: String?
    var title: String?
    var destination_id: NSNumber?
}

class YJTravelGuideModel: NSObject {
    var category: String?
//    var tmpDes: [detailModel]?
    
    var destinations: [detailModel]?
    
    class func modelContainerPropertyGenericClass() -> [String: AnyObject] {
        return [
            "destinations": detailModel.self
        ]
    }
//        {
//        willSet{
//            
//           self.tmpDes = (NSArray.yy_modelArrayWithClass(detailModel.self, json: newValue!) as! [detailModel])
//            
//        }
//    }
}

class detailModel: NSObject {
    var id: NSNumber?
    var name_zh_cn: String?
    var name_en: String?
    var poi_count: NSNumber?
    var lat: NSNumber?
    var lng: NSNumber?
    var image_url: String?
    
}

class travelDetailModel: NSObject {
    var id: NSNumber?
    var name_zh_cn: String?
    var name_en: String?
    var image_url: String?
}

class tripsModel: NSObject {
    var id: NSNumber?
    var level: NSNumber?
    var front_cover_photo_id: NSNumber?
    var name: String?
    var start_data: String?
    var end_data: String?
    var photos_count: NSNumber?
    var trip_days = [tripDetail]()
    
    class func modelContainerPropertyGenericClass() -> [String: AnyObject] {
        return [
            "trip_days": tripDetail.self
        ]
    }
}

class tripDetail: NSObject {
    var day: NSNumber?
    var destination: desModel?
    var id: NSNumber?
    var trip_date: String?
    var nodes: [nodes_Model]?
    var notes: [notes_Model]? = [notes_Model]()
    
    
    func modelCustomTransformFromDictionary(dic: [NSObject : AnyObject]) -> Bool {
        for node in nodes! {
            //将nodes取出来并将遍历后的结果添加到notes中
            notes?.appendContentsOf(node.notes!)
        }
        return true
    }
    
    //数组里装的其他模型时  需要补充这个方法 否则数组里的模型赋不上值
    class func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["nodes": nodes_Model.self]
    }
}

class desModel: NSObject {
    var id: NSNumber?
    var name_zh_cn: String?
}

class nodes_Model: NSObject {
    
    var attraction_type: String?
    var comment: String?
    var entry_id: NSNumber?
    var entry_name: String?
    var entry_type: String?
    var id: NSNumber?
    var lat: NSNumber?
    var lng: NSNumber?
    var memo: memo_Model?
    var notes: [notes_Model]?
    
    //数组里装的其他模型时  需要补充这个方法 否则数组里的模型赋不上值
    class func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["notes": notes_Model.self]
    }
}

class memo_Model: NSObject {
    
}

class notes_Model: NSObject {
    var col: NSNumber?
    var desc: String?
    var id: NSNumber?
    var layout: String?
    var photo: photo_Model?
    var row_order: NSNumber?
    var updated_at :NSNumber?
    var video: video_Model?
    class func modelCustomPropertyMapper() -> [String : AnyObject]? {
        return ["desc": "description"]
    }
}

class photo_Model: NSObject {
    var exif_date_time_original: NSNumber?
    var exif_lat: NSNumber?
    var exif_lng: NSNumber?
    var id: NSNumber?
    var image_file_size: NSNumber?
    var image_height: Int = 0
    var image_width: NSNumber?
    var url: String?
}

class video_Model: NSObject {
    
    var id: NSNumber?
    var lat: String?
    var lng: String?
    var recorded_at: NSNumber?
    var time_length: NSNumber?
    var url: String?
    var video_height: NSNumber?
    var video_width: NSNumber?
    
}

//专题模型
class specialTableModel: NSObject {
    
    var article_sections: [Article_Sections]?

    var current_user_favorite: Bool = false

    var id: Int = 0

    var image_url: String?

    var title: String?

    var destination_id: Int = 0

    var commentable: Bool = false

    var updated_at: Int = 0

    var comments_count: Int = 0

    var name: String?
    
    class func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["article_sections": Article_Sections.self]
    }
    
}

class Article_Sections: NSObject {

    var desc: String?

    var title: String?

    var image_url: String?

    var image_width: Int = 0

    var image_height: Int = 0
    
    class func modelCustomPropertyMapper() -> [String : AnyObject]? {
        return ["desc": "description"]
    }

    var description_user_ids: [String: String]?

}

