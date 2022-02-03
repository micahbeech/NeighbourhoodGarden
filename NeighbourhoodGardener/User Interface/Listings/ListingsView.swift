//
//  ListingsVIew.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-03.
//

import SwiftUI
import Swinject

// MARK: ViewState

extension ListingsView {
    struct ViewState {
        let listings: [ListingCard.ViewModel]
    }
}

// MARK: View

struct ListingsView: View {
    typealias ViewModel = AnyViewModel<ViewState, Never>
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        List(viewModel.state.listings) { listing in
            ListingCard(viewModel: listing)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

// MARK: Previews

struct ListingsView_Previews: PreviewProvider {
    static let listingsView = GardenAssembler().resolver.resolve(ListingsView.self, name: "Preview")

    static var previews: some View {
        PreviewGroup {
            listingsView
        }
    }
}

private extension ListingsView.ViewState {
    static let preview = Self(
        listings: [
            "Lettuce",
            "Tomato",
            "Beets",
            "A whole lotta potatoes",
            "Peanuts"
        ].map({ name in
            ListingCard.ViewModel(
                productName: name,
                description: "I am a \(name)",
                price: "$\(Int.random(in: 0...100)).\(Int.random(in: 0...9))\(Int.random(in: 0...9))",
                seller: "All about \(name)",
                images: Array(repeating: "testimage", count: Int.random(in: 1...5))
            )
        })
    )
}

// MARK: Assemblies

// final class ListingsViewAssembly: Assembly {
//    func assemble(container: Container) {
//        container.register(ListingsView.self) { resolver in
//            let viewModel = resolver.resolve(HomeTab.ViewModel.self)!
//            return ListingsView(viewModel: viewModel)
//        }
//    }
// }

final class ListingsViewPreviewAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ListingsView.self, name: "Preview") { _ in
            return ListingsView(viewModel: .init(state: .preview))
        }
    }
}
