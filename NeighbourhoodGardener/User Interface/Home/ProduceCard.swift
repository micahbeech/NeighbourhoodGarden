//
//  ProduceCard.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI

// MARK: ViewModel

extension ProduceCard {
    struct ViewModel: IdentifiableViewModel {
        let productName: String
        let description: String
        let price: String
        let seller: String
        let imageUrl: String
    }
}

// MARK: View

struct ProduceCard: View {
    let viewModel: ViewModel

    var body: some View {
        CardView {
            ProduceView(viewModel: .init(
                name: viewModel.productName,
                description: viewModel.description,
                price: viewModel.price,
                seller: viewModel.seller,
                imageUrl: viewModel.imageUrl
            ))
                .padding(.screenEdge)
        }
        .frame(height: 180)
    }
}

// MARK: Previews

struct ProduceCard_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            ProduceCard(viewModel: .preview)
        }
    }
}

private extension ProduceCard.ViewModel {
    static let preview = Self(
        productName: "Lettuce",
        description: "I am some tasty lettuce",
        price: "$4.95",
        seller: "Leafy Farmers",
        imageUrl: "testimage"
    )
}
