//
//  ListingsViewModel.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-09.
//

import Foundation
import Swinject

// MARK: ListingsViewModel

final class ListingsViewModel: ViewModel {
    typealias State = ListingsView.ViewState
    typealias Event = Void

    @Published var state = ListingsView.ViewState(listings: [])

    private var listingsManager: ListingsManager

    init(listingsManager: ListingsManager) {
        self.listingsManager = listingsManager
        self.listingsManager.onUpdateListings = updateState
        self.updateState(listings: listingsManager.getListings())
    }

    func updateState(listings: [ListingCard.ViewModel]) {
        self.state = .init(listings: listings)
    }
}

// MARK: ListingsViewModelAssembly

final class ListingsViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ListingsView.ViewModel.self) { resolver in
            let listingsManager = resolver.resolve(ListingsManager.self)!
            return ListingsViewModel(listingsManager: listingsManager).eraseToAnyViewModel()
        }
    }
}
