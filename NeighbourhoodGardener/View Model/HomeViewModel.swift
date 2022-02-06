//
//  RealHomeViewModel.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-31.
//

import Foundation
import Swinject

// MARK: HomeViewModel

final class HomeViewModel: ViewModel {
    typealias State = HomeTab.ViewState
    typealias Event = Void

    @Published var state = HomeTab.ViewState(title: L10n.Home.header, products: [])

    private let numberFormatter = CurrencyFormatter()
    private let subscriberManager = SubscriberManager()
    private let productService: ProductService

    init(productService: ProductService) {
        self.productService = productService

        self.getProducts()
    }
}

// MARK: Private methods

extension HomeViewModel {
    private func getProducts() {
        self.productService.getProducts()
            .map {
                $0.map { [weak self] product in
                    .init(
                        productName: product.name,
                        description: product.description,
                        price: self?.numberFormatter.string(from: product.price) ?? "",
                        seller: product.seller,
                        imageUrl: product.imageUrls.first ?? ""
                    )
                }
            }
            .map { .init(title: L10n.Home.header, products: $0) }
            .receive(on: RunLoop.main)
            .assign(to: \.state, on: self)
            .store(in: &subscriberManager.cancellables)
    }
}

// MARK: HomeViewModelAssembly

final class HomeViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeTab.ViewModel.self) { resolver in
            let productService = resolver.resolve(ProductService.self)!
            return HomeViewModel(productService: productService).eraseToAnyViewModel()
        }
    }
}
