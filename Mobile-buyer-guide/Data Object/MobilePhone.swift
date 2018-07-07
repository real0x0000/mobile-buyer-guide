//
//  MobilePhone.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 5/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class MobilePhone: Object {
    
    @objc dynamic var thumbImageUrl: String? = nil
    @objc dynamic var name: String = ""
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var id: Int = 0
    @objc dynamic var price: Double = 0.0
    @objc dynamic var desc: String = ""
    @objc dynamic var brand: String = ""
    @objc dynamic var isFavorite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func saveJSON(_ json: JSON) {
        let realm = try! Realm()
        let id = json["id"].intValue
        let mobile = MobilePhone()
        mobile.thumbImageUrl = json["thumbImageURL"].string
        mobile.name = json["name"].stringValue
        mobile.rating = json["rating"].doubleValue
        mobile.id = id
        mobile.price = json["price"].doubleValue
        mobile.desc = json["description"].stringValue
        mobile.brand = json["brand"].stringValue
        if let mb = realm.object(ofType: MobilePhone.self, forPrimaryKey: id) {
            mobile.isFavorite = mb.isFavorite
        }
        try! realm.write {
            realm.add(mobile, update: true)
        }
    }

    static func getAll() -> [MobilePhone] {
        let realm = try! Realm()
        let list = realm.objects(MobilePhone.self)
        return Array(list)
    }
    
    static func getFavoriteList() -> [MobilePhone] {
        return getAll().filter { $0.isFavorite }
    }
    
    static func updateFavorite(_ id: Int, isFavorite: Bool) {
        let realm = try! Realm()
        if let mobile = realm.object(ofType: MobilePhone.self, forPrimaryKey: id) {
            try! realm.write {
                mobile.isFavorite = isFavorite
            }
        }
    }
    
}




