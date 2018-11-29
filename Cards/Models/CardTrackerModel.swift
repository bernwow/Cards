//
//  CardTrackerModel.swift
//  Cards
//
//  Created by Bern on 28.11.2018.
//  Copyright © 2018 Bern. All rights reserved.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift

struct CardTrackerModel {
    
    let provider: MoyaProvider<Scryfall>
    let cardName: Observable<String>
    
    func trackCards() -> Observable<[Card]?> {
        return cardName
            .observeOn(MainScheduler.instance)
            .flatMapLatest { name -> Observable<[Card]?> in
                print("Name: \(name)")
                return self
                    .findCard(name)
            }
    }
    
    internal func findCard(_ name: String) -> Observable<[Card]?> {
        return self.provider.rx
            .request(Scryfall.cards(cardName: name))
            .debug()
            .mapOptional(to: [Card].self, keyPath: "data")
            .asObservable()
    }
}
