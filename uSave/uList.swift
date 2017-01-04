//
//  ListContent.swift
//  uSave
//
//  Created by Sunrin on 2017. 1. 4..
//  Copyright © 2017년 Conota. All rights reserved.
//

struct uList {
    
    var tmpImg: String?
    var url: String
    
    init(url : String, tmpImg : String? = nil){
        self.url = url
        self.tmpImg = tmpImg
    }
    
    
    init?(dictionary : [String: Any]){
        guard let tmpImg = dictionary["tmpImg"] as? String,
            let url = dictionary["url"] as? String
            else { return nil }
        self.tmpImg = tmpImg
        self.url = url
    }
    
}
