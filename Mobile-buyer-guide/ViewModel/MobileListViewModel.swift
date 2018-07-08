//
//  MobileListViewModel.swift
//  Mobile-buyer-guide
//
//  Created by Anuwat Sittichak on 6/7/2561 BE.
//  Copyright © 2561 real0x0000. All rights reserved.
//

import RxSwift

class MobileListViewModel {
    
    fileprivate let disposeBag = DisposeBag()
    let rx_mobileList: BehaviorSubject<[MobilePhone]> = BehaviorSubject(value: [])

    init() {
        MainViewModel.share.rx_sortType
            .filter { $0 != SortType.none }
            .subscribe(onNext: { [unowned self] _ in
                self.getMobileList()
            }).disposed(by: disposeBag)
        MainViewModel.share.rx_isUpdateList
            .filter { $0 }
            .subscribe(onNext: { [unowned self] _ in
                self.getMobileList()
            }).disposed(by: disposeBag)
    }

    func getMobileList() {
        let list = MainViewModel.share.sortMobileList(MobilePhone.getAll())
        self.rx_mobileList.onNext(list)
    }
    
    func updateFavorite(_ id: Int, isFavorite: Bool) {
        MobilePhone.updateFavorite(id, isFavorite: isFavorite)
    }
    
}
