//
//  ProductManager.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-09.
//

import Foundation
import Swinject

// MARK: ProductManager

protocol ProductManager {
    func getProducts() -> [ProduceCard.ViewModel]
    var onUpdateProducts: (([ProduceCard.ViewModel]) -> Void)? { get set }
}

// MARK: RealProductManager

final class RealProductManager {
    var onUpdateProducts: (([ProduceCard.ViewModel]) -> Void)?

    private var currentProducts = [ProduceCard.ViewModel]()

    private let numberFormatter = CurrencyFormatter()
    private let subscriberManager = SubscriberManager()
    private let productService: ProductService

    init(productService: ProductService) {
        self.productService = productService

        self.retrieveProducts()
    }
}

// MARK: ProductManager

extension RealProductManager: ProductManager {
    func getProducts() -> [ProduceCard.ViewModel] {
        currentProducts
    }
}

// MARK: Private methods

extension RealProductManager {
    private func retrieveProducts() {
        self.productService.getProducts()
            .map {
                $0.map { [weak self] product in
                    ProduceCard.ViewModel(
                        productName: product.name,
                        description: product.description,
                        price: self?.numberFormatter.string(from: product.price) ?? "",
                        seller: product.seller,
                        imageUrl: product.imageUrls.first ?? ""
                    )
                }
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.currentProducts = $0
                self?.onUpdateProducts?($0)
            }
            .store(in: &subscriberManager.cancellables)
    }
}

// MARK: RealProductManagerAssembly

final class RealProductManagerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProductManager.self) { resolver in
            let productService = resolver.resolve(ProductService.self)!
            return RealProductManager(productService: productService)
        }
        .inObjectScope(.container)
    }
}
