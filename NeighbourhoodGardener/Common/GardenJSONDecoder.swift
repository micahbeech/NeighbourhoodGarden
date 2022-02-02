//
//  GardenJSONDecoder.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-01.
//

import Foundation

final class GardenJSONDecoder: JSONDecoder {
    override init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
    }

    func decodeOrNull<T>(_ type: T.Type, from data: Data) -> T? where T: Decodable {
        try? decode(type, from: data)
    }
}
