//
//  CardEntity.swift
//  Cards
//
//  Created by Bern on 28.11.2018.
//  Copyright © 2018 Bern. All rights reserved.
//

import Mapper

struct Card: Mappable {
    
    let oracleText: String
    let imageUrl: String

    init(map: Mapper) throws {
        try oracleText = map.from("oracle_text")
        try imageUrl = map.from("image_uris.normal");
    }
}
