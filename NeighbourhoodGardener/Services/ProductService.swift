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
    func createProduct(product: Product) -> AnyPublisher<[Product], Never>
}

// MARK: RealProductService

final class RealProductService: ProductService {
    private let gardenAPI: GardenAPI

    init(gardenAPI: GardenAPI) {
        self.gardenAPI = gardenAPI
    }

    func getProducts() -> AnyPublisher<[Product], Never> {
        gardenAPI.getResource([Product].self, path: "/products")
    }

    func createProduct(product: Product) -> AnyPublisher<[Product], Never> {
        gardenAPI.createResource(product, [Product].self, path: "/products")
    }
}

// MARK: RealProductServiceAssembly

final class RealProductServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProductService.self) { resolver in
            let gardenApi = resolver.resolve(GardenAPI.self)!
            return RealProductService(gardenAPI: gardenApi)
        }
    }
}
