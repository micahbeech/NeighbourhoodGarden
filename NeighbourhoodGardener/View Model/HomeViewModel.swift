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
    typealias Event = Never

    @Published var state = HomeTab.ViewState(title: L10n.Home.header, products: [])
    private var products = [Product]()

    private let productService: ProductService

    init(productService: ProductService) {
        self.productService = productService

        self.getProducts()
    }
}

// MARK: Private methods

extension HomeViewModel {
    private func setState() {
        let numberFormatter = NumberFormatter()
        let productViewModels = products.map { product in
            ProduceCard.ViewModel(
                productName: product.name,
                description: product.description,
                price: numberFormatter.string(from: product.price) ?? "",
                seller: product.seller,
                imageUrl: product.imageUrls.first ?? ""
            )
        }
        self.state = .init(title: L10n.Home.header, products: productViewModels)
    }

    private func getProducts() {
        Task { [weak self] in
            guard let self = self else { return }
            self.products = await self.productService.getProducts()
            DispatchQueue.main.async { [weak self] in
                self?.setState()
            }
        }
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
