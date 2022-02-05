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
    struct ViewState: DefaultIdentifiable {
        let listings: [ListingCard.ViewModel]
    }
}

// MARK: View

struct ListingsView: View {
    typealias ViewModel = AnyViewModel<ViewState, Never>
    @ObservedInject var viewModel: ViewModel

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
    static var previews: some View {
        PreviewGroup {
            ListingsView()
                .injectPreview(ListingsView.ViewModel.self)
        }
    }
}

extension ListingsView.ViewState: StatePreviewable {
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
