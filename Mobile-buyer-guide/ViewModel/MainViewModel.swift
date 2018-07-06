//
//  MainViewModel.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 5/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import RxSwift

class MainViewModel {
    
    let rx_mobileList: BehaviorSubject<[MobilePhone]> = BehaviorSubject(value: [])
    
    func getMobileList() {
        let path = "https://scb-test-mobile.herokuapp.com/api/mobiles"
        ConnectionController.share.makeRequest(path, onCompletion: { (result) in
            if let json = result {
                let mobileList = json.map { (_, js) in MobilePhone.parseJSON(js) }
                self.rx_mobileList.onNext(mobileList)
            }
        }, onError: { (error) in
            print(error)
        })
    }
    
}
