//
//  ListingCard.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-03.
//

import SwiftUI

// MARK: ViewModel

extension ListingCard {
    struct ViewModel: DefaultIdentifiable {
        let productName: String
        let description: String
        let price: String
        let images: [String]
    }
}

// MARK: View

struct ListingCard: View {
    let viewModel: ViewModel

    var body: some View {
        CardView {
            VStack(spacing: .zero) {
                HorizontalList(viewModel.images, id: \.self) { url in
                    GardenImage(imageUrl: url, size: 120)
                        .padding(.leading, .screenEdge)
                        .if(url == viewModel.images.last) { $0.padding(.trailing, .screenEdge) }
                }
                .padding(.vertical, .screenEdge)

                GardenDivider(weight: 2)
                    .ignoresSafeArea()

                ProductInfo(viewModel: .init(
                    name: viewModel.productName,
                    description: viewModel.description,
                    price: viewModel.price,
                    seller: nil
                ))
                    .padding(.screenEdge)
            }
        }
    }
}

// MARK: Previews

struct ListingCard_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            ListingCard(viewModel: .preview)
        }
    }
}

extension ListingCard.ViewModel {
    static let preview = Self(
        productName: "Listing",
        description: "I am a listing",
        price: "$42.55",
        images: ["testimage1", "testimage2", "testimage3", "testimage4"]
    )
}
