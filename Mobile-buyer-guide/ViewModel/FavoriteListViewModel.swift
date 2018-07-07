//
//  FavoriteListViewModel.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 6/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import RxSwift

class FavoriteListViewModel {
    
    let rx_favoriteList: BehaviorSubject<[MobilePhone]> = BehaviorSubject(value: [])

    func getFavoriteList() {
        self.rx_favoriteList.onNext(MobilePhone.getFavoriteList())
    }

    func updateFavorite(_ id: Int, isFavorite: Bool) {
        MobilePhone.updateFavorite(id, isFavorite: isFavorite)
    }
    
}
