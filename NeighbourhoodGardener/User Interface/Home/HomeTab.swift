//
//  HomeTab.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI
import Swinject

// MARK: ViewState

extension HomeTab {
    struct ViewState: DefaultIdentifiable {
        var title: String
        var products: [ProduceCard.ViewModel]
    }
}

// MARK: View

struct HomeTab: View {
    typealias ViewModel = AnyViewModel<ViewState, Void>
    @ObservedInject private var viewModel: ViewModel

    var body: some View {
        List {
            Text(viewModel.state.title)
                .titleStyle()
                .listRowSeparator(.hidden)

            ForEach(viewModel.state.products) { product in
                ProduceCard(viewModel: product)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
}

// MARK: Previews

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            HomeTab()
                .injectPreview(HomeTab.ViewModel.self)
        }
    }
}

extension HomeTab.ViewState: StatePreviewable {
    static let preview = Self(
        title: "Neighbourhood Garden",
        products: [
            "Lettuce",
            "Tomato",
            "Beets",
            "A whole lotta potatoes",
            "Peanuts"
        ].map({ name in
            ProduceCard.ViewModel(
                productName: name,
                description: "I am a \(name)",
                price: "$\(Int.random(in: 0...100)).\(Int.random(in: 0...9))\(Int.random(in: 0...9))",
                seller: "All about \(name)",
                imageUrl: "testimage"
            )
        })
    )
}
