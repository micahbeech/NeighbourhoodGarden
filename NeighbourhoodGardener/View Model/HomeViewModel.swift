//
//  RealHomeViewModel.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-31.
//

import Foundation
import Swinject

protocol Test {
    var title: String { get }
    var products: [ProduceCard.ViewModel] { get }
}

final class HomeViewModel: ViewModel {
    typealias State = HomeTab.ViewState
    typealias Event = Never

    @Published var state = HomeTab.ViewState(title: L10n.Home.header, products: [])

    let productService: ProductService

    init(productService: ProductService) {
        self.productService = productService

        Task {
            await self.getProducts()
        }
    }
}

extension HomeViewModel {
    private func getProducts() async {
        let numberFormatter = NumberFormatter()
        let products = await self.productService.getProducts().map { product in
            ProduceCard.ViewModel(
                productName: product.name,
                description: product.description,
                price: numberFormatter.string(from: product.price) ?? "",
                seller: product.seller,
                imageUrl: product.imageUrls.first ?? ""
            )
        }
        self.state = .init(title: L10n.Home.header, products: products)
    }
}

final class HomeViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeTab.ViewModel.self) { resolver in
            let productService = resolver.resolve(ProductService.self)!
            return HomeViewModel(productService: productService).eraseToAnyViewModel()
        }
    }
}
