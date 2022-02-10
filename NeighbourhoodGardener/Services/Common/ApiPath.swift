//
//  ApiPath.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-09.
//

import Foundation
import Alamofire

struct ApiPath: URLConvertible {
    #if LOCAL
    private let baseAPI = "http://localhost:8080"
    #else
    // not defined, will not compile
    #endif
    private let path: String

    init(_ rawValue: String) {
        self.path = rawValue
    }

    func asURL() throws -> URL {
        guard let url = URL(string: baseAPI + path) else {
            throw URLError(.badURL)
        }
        return url
    }
}
