//
//  ProductService.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-31.
//

import Foundation
import Swinject

// MARK: ProductService

protocol ProductService {
    func getProducts() async -> [Product]
}

// MARK: RealProductService

final class RealProductService: ProductService {
    func getProducts() async -> [Product] {
        // FIX ME: Temporary Implementation
        let data = PreviewData.products.data.data
        return GardenJSONDecoder().decodeOrNull([Product].self, from: data) ?? []
    }
}

// MARK: RealProductServiceAssembly

final class RealProductServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProductService.self) { _ in
            RealProductService()
        }
    }
}
