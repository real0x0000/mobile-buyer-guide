//
//  Properties.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 5/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

enum SortType {
    case none
    case lowPrice
    case highPrice
    case rating
}

class Properties {
    
    class Service {
        static let SERVICE_URL = "https://scb-test-mobile.herokuapp.com/api/mobiles"
    }
    
    class Message {
        static let MESSAGE_ERROR_INTERNET = "พบข้อผิดพลาดในการเชื่อมต่ออินเตอร์เน็ต"
        static let MESSAGE_ERROR_RESPONSE = "พบข้อผิดพลาด ไม่สามารถเชื่อมต่อกับเซิฟเวอร์ได้"
    }
    
    
}
