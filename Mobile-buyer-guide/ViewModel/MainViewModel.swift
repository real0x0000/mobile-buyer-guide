//
//  MainViewModel.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 5/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import RxSwift

class MainViewModel {
    
    static let share = MainViewModel()
    let rx_sortType: BehaviorSubject<SortType> = BehaviorSubject(value: SortType.none)
    let rx_isUpdateList: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    func getMobileList() {
        let path = Properties.Service.SERVICE_URL
        ConnectionController.share.makeRequest(path, onCompletion: { (result) in
            if let json = result {
                json.forEach { (_, js) in
                    MobilePhone.saveJSON(js)
                }
                self.rx_isUpdateList.onNext(true)
            }
        }, onError: { (error) in
            AlertController.share.show(fromViewController: UIApplication.topViewController()!, title: error)
        })
    }
    
    func sortMobileList(_ list: [MobilePhone]) -> [MobilePhone] {
        let sortType = try! rx_sortType.value()
        switch sortType {
        case .lowPrice:
            return list.sorted(by: { $0.price < $1.price })
        case .highPrice:
            return list.sorted(by: { $0.price > $1.price})
        case .rating:
            return list.sorted(by: { $0.rating > $1.rating})
        default:
            return list
        }
    }
    
}
