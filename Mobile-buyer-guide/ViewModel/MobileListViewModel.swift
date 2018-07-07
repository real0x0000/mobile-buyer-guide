//
//  MobileListViewModel.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 6/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import RxSwift

class MobileListViewModel {
    
    fileprivate let mainVM = MainViewModel()
    let rx_mobileList: BehaviorSubject<[MobilePhone]> = BehaviorSubject(value: [])
//    let rx_sorting: BehaviorSubject<
    
    func getMobileList() {
        self.rx_mobileList.onNext(MobilePhone.getAll())
    }
    
    func updateFavorite(_ id: Int, isFavorite: Bool) {
        MobilePhone.updateFavorite(id, isFavorite: isFavorite)
    }
    
}
