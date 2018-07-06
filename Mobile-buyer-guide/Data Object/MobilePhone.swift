//
//  MobilePhone.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 5/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import RealmSwift
import SwiftyJSON

struct MobilePhone {
    
    var thumbImageUrl: String?
    var name: String
    var rating: Double
    var id: Int
    var price: Double
    var desc: String
    var brand: String
    
}

extension MobilePhone {
    
    static func parseJSON(_ json: JSON) -> MobilePhone {
        let thumbImageUrl = json["thumbImageUrl"].string
        let name = json["name"].stringValue
        let rating = json["rating"].doubleValue
        let id = json["id"].intValue
        let price = json["price"].doubleValue
        let desc = json["description"].stringValue
        let brand = json["brand"].stringValue
        return MobilePhone(thumbImageUrl: thumbImageUrl, name: name, rating: rating, id: id, price: price, desc: desc, brand: brand)
    }
    
}


