//
//  FavoriteListViewModel.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 6/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import RxSwift

class FavoriteListViewModel {
    
    fileprivate let disposeBag = DisposeBag()
    let rx_favoriteList: BehaviorSubject<[MobilePhone]> = BehaviorSubject(value: [])

    init() {
        MainViewModel.share.rx_sortType
            .filter { $0 != SortType.none }
            .subscribe(onNext: { [unowned self] _ in
               self.updateList()
            }).disposed(by: disposeBag)
        MainViewModel.share.rx_isUpdateList
            .filter { $0 }
            .subscribe(onNext: { [unowned self] _ in
                self.getFavoriteList()
            }).disposed(by: disposeBag)
    }
    
    func updateList() {
        if let list = try? rx_favoriteList.value(), list.count != 0 {
            self.rx_favoriteList.onNext(MainViewModel.share.sortMobileList(list))
        }
    }
    
    func getFavoriteList() {
        let list = MainViewModel.share.sortMobileList(MobilePhone.getFavoriteList())
        self.rx_favoriteList.onNext(list)
    }

    func updateFavorite(_ id: Int, isFavorite: Bool) {
        MobilePhone.updateFavorite(id, isFavorite: isFavorite)
    }
    
}
