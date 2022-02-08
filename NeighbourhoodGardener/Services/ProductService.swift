//
//  ProductService.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-31.
//

import Foundation
import Swinject
import Combine

// MARK: ProductService

// sourcery: AutoMockable
protocol ProductService {
    func getProducts() -> AnyPublisher<[Product], Never>
}

// MARK: RealProductService

final class RealProductService: ProductService {
    func getProducts() -> AnyPublisher<[Product], Never> {
        // FIX ME: Temporary Implementation
        let data = PreviewData.products.data.data
        let products = GardenJSONDecoder().decodeOrNull([Product].self, from: data) ?? []
        return Just(products).eraseToAnyPublisher()
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
