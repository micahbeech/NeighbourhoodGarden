//
//  ListingsViewModel.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-05.
//

import Foundation
import Swinject

// MARK: ListingsViewModel

final class ListingsViewModel: ViewModel {
    typealias State = ListingsView.ViewState
    typealias Event = Void

    @Published var state = ListingsView.ViewState(listings: [])

    private let numberFormatter = CurrencyFormatter()
    private let subscriberManager = SubscriberManager()
    private let productService: ProductService

    init(productService: ProductService) {
        self.productService = productService

        self.getListings()
    }
}

// MARK: Private Methods

extension ListingsViewModel {
    private func getListings() {
        self.productService.getProducts()
            .map {
                $0.map { [weak self] product in
                    .init(
                        productName: product.name,
                        description: product.description,
                        price: self?.numberFormatter.string(from: product.price) ?? "",
                        images: product.imageUrls
                    )
                }
            }
            .map { .init(listings: $0) }
            .receive(on: RunLoop.main)
            .assign(to: \.state, on: self)
            .store(in: &subscriberManager.cancellables)
    }
}

// MARK: ListingsViewModelAssembly

final class ListingsViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ListingsView.ViewModel.self) { resolver in
            let productService = resolver.resolve(ProductService.self)!
            return ListingsViewModel(productService: productService).eraseToAnyViewModel()
        }
    }
}
