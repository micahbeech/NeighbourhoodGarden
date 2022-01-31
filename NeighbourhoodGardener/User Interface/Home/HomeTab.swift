//
//  HomeTab.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI

struct HomeTab: View {
    let products: [ProduceCard.ViewModel]

    var body: some View {
        List(products) { product in
            ProduceCard(viewModel: product)
                .listRowSeparator(.hidden)
                .ignoresSafeArea()
        }
        .listStyle(.plain)
    }
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            HomeTab(products: [
                .preview("Lettuce"),
                .preview("Tomato"),
                .preview("Beets"),
                .preview("A whole lotta potatoes"),
                .preview("Peanuts")
            ])
        }
    }
}

private extension ProduceCard.ViewModel {
    static func preview(_ name: String) -> Self {
        return Self(
            productName: name,
            description: "I am a \(name)",
            price: "$\(Int.random(in: 0...100)).\(Int.random(in: 0...9))\(Int.random(in: 0...9))",
            seller: "All about \(name)",
            imageUrl: "testimage"
        )
    }
}
