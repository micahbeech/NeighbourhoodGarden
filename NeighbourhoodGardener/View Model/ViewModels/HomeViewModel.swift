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

    private var productManager: ProductManager

    init(productManager: ProductManager) {
        self.productManager = productManager
        self.productManager.onUpdateProducts = updateState
        self.updateState(products: productManager.getProducts())
    }

    func updateState(products: [ProduceCard.ViewModel]) {
        self.state = .init(title: L10n.Home.header, products: products)
    }
}

// MARK: HomeViewModelAssembly

final class HomeViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeTab.ViewModel.self) { resolver in
            let productManager = resolver.resolve(ProductManager.self)!
            return HomeViewModel(productManager: productManager).eraseToAnyViewModel()
        }
    }
}
