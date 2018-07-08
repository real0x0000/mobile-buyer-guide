//
//  MobileDetailViewModel.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 7/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import RxSwift
import SwiftyJSON

class MobileDetailViewModel {
    
    let rx_mobile: BehaviorSubject<MobilePhone?> = BehaviorSubject(value: nil)
    let rx_mobileImagesUrl: BehaviorSubject<[String]> = BehaviorSubject(value: [])
    
    func applyMobile(_ mobile: MobilePhone) {
        rx_mobile.onNext(mobile)
    }
    
    func getMobileImages(_ id: Int) {
        let path = "https://scb-test-mobile.herokuapp.com/api/mobiles/\(id)/images/"
        ConnectionController.share.makeRequest(path, onCompletion: { (result) in
            if let json = result {
                let imagesUrl = json.map { (_, js) in self.addHttp(js["url"].stringValue) }
                self.rx_mobileImagesUrl.onNext(imagesUrl)
            }
        }, onError: { (error) in
            print(error)
        })
    }
    
    fileprivate func addHttp(_ url: String) -> String {
        if url.range(of: "http") == nil {
            return "http://" + url
        }
        return url
    }
    
}
