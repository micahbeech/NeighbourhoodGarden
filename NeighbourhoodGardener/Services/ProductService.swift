//
//  ProductService.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-31.
//

import Foundation
import Swinject

protocol ProductService {
    func getProducts() async -> [Product]
}

final class RealProductService: ProductService {
    func getProducts() async -> [Product] {
        // FIX ME: Temporary Implementation
        let data = PreviewData.products.data.data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let products = try? decoder.decode([Product].self, from: data)
        return products ?? []
    }
}

final class RealProductServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProductService.self) { _ in
            RealProductService()
        }
    }
}
