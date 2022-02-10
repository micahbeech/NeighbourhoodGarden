//
//  ListingsManager.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-05.
//

import Foundation
import Swinject
import Combine

// MARK: ListingsManager

protocol ListingsManager {
    func addListing(name: String, description: String, price: String)
    func getListings() -> [ListingCard.ViewModel]
    var onUpdateListings: (([ListingCard.ViewModel]) -> Void)? { get set }
}

// MARK: RealListingsManager

final class RealListingsManager {
    var onUpdateListings: (([ListingCard.ViewModel]) -> Void)?

    private var currentListings = [ListingCard.ViewModel]()

    private let currencyFormatter = CurrencyFormatter()
    private let subscriberManager = SubscriberManager()
    private let productService: ProductService

    init(productService: ProductService) {
        self.productService = productService

        self.retrieveListings()
    }
}

// MARK: ListingsManager Methods

extension RealListingsManager: ListingsManager {
    func addListing(name: String, description: String, price: String) {
        processListings(from: productService.createProduct(
            product: Product(
                name: name,
                description: description,
                seller: "sells \(name)",
                price: currencyFormatter.money(from: price, currency: .CAD) ?? .init(amountMinor: 0, currency: .CAD),
                imageUrls: [name]
            )
        ))
    }

    func getListings() -> [ListingCard.ViewModel] {
        currentListings
    }
}

// MARK: Private Methods

extension RealListingsManager {
    private func retrieveListings() {
        processListings(from: productService.getProducts())
    }

    private func processListings(from publisher: AnyPublisher<[Product], Never>) {
        publisher
            .map {
                $0.map { [weak self] product in
                    ListingCard.ViewModel(
                        productName: product.name,
                        description: product.description,
                        price: self?.currencyFormatter.string(from: product.price) ?? "",
                        images: product.imageUrls
                    )
                }
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.currentListings = $0
                self?.onUpdateListings?($0)
            }
            .store(in: &subscriberManager.cancellables)
    }
}

// MARK: ListingsViewModelAssembly

final class RealListingsManagerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ListingsManager.self) { resolver in
            let productService = resolver.resolve(ProductService.self)!
            return RealListingsManager(productService: productService)
        }
        .inObjectScope(.container)
    }
}
