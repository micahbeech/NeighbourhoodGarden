//
//  HomeTab.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI
import Swinject

extension HomeTab {
    struct ViewState {
        var title: String
        var products: [ProduceCard.ViewModel]
    }
}

struct HomeTab: View {
    typealias ViewModel = AnyViewModel<ViewState, Never>
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: .small) {
            Text(viewModel.state.title)
                .titleStyle()
                .padding([.horizontal, .top], .screenEdge)

            List(viewModel.state.products) { product in
                ProduceCard(viewModel: product)
                    .listRowSeparator(.hidden)
                    .ignoresSafeArea()
            }
            .listStyle(.plain)
        }
    }
}

struct HomeTab_Previews: PreviewProvider {
    static let homeTab = GardenAssembler().resolver.resolve(HomeTab.self, name: "Preview")

    static var previews: some View {
        PreviewGroup { homeTab }
    }
}

private extension HomeTab.ViewState {
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

final class HomeTabAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeTab.self) { resolver in
            let viewModel = resolver.resolve(HomeTab.ViewModel.self)!
            return HomeTab(viewModel: viewModel)
        }
    }
}

final class HomeTabPreviewAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeTab.self, name: "Preview") { _ in
            return HomeTab(viewModel: .init(state: .preview))
        }
    }
}
