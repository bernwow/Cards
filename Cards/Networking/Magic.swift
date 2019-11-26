//
//  Magic.swift
//  Cards
//
//  Created by Bern on 28.11.2018.
//  Copyright © 2018 Bern. All rights reserved.
//

import Foundation
import Moya

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

enum Magic {
    case cards(cardName: String)
}

extension Magic: TargetType {
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL { return URL(string: "https://api.scryfall.com")! }
    var path: String {
        switch self {
        case .cards(_):
            return "/cards/search/"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var parameters: [String: Any]? {
        switch self {
        case .cards(let cardName):
            return ["q": cardName.URLEscapedString]
        }
    }
    var sampleData: Data {
        switch self {
        case .cards(_):
            return "".data(using: .utf8)!
        }
    }
    var task: Task {
        return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
    }
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.queryString
    }
}
