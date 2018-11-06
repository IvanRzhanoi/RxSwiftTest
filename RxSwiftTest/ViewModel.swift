//
//  ViewModel.swift
//  RxSwiftTest
//
//  Created by Ivan Rzhanoi on 06/11/2018.
//  Copyright © 2018 Ivan Rzhanoi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ViewModel {
    
    let searchText = BehaviorRelay(value: "")
    
    let APIProvider: APIProvider
    var data: Driver<[Repository]>
    
    init(APIProvider: APIProvider) {
        self.APIProvider = APIProvider
        
        data = self.searchText.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest {
                APIProvider.getRepositories($0)
        }.asDriver(onErrorJustReturn: [])
    }
    
}
