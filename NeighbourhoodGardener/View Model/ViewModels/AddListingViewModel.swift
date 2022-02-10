//
//  AddListingViewModel.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-09.
//

import Foundation
import Swinject

// MARK: AddListingViewModel

final class AddListingViewModel: ViewModel {
    typealias State = AddListingView.ViewState
    typealias Event = AddListingView.ViewEvent

    @Published var state = AddListingView.ViewState()

    private let listingsManager: ListingsManager

    init(listingsManager: ListingsManager) {
        self.listingsManager = listingsManager
    }

    func trigger(_ event: AddListingView.ViewEvent) {
        switch event {
        case .addListing(let name, let description, let price):
            listingsManager.addListing(name: name, description: description, price: price)
        }
    }
}

// MARK: AddListingViewModelAssembly

final class AddListingViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AddListingView.ViewModel.self) { resolver in
            let listingsManager = resolver.resolve(ListingsManager.self)!
            return AddListingViewModel(listingsManager: listingsManager).eraseToAnyViewModel()
        }
    }
}
