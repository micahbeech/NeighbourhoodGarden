//
//  ListingCard.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-03.
//

import SwiftUI

// MARK: ViewModel

extension ListingCard {
    struct ViewModel: IdentifiableViewModel {
        let productName: String
        let description: String
        let price: String
        let seller: String
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
                    GardenImage(imageUrl: url, size: nil)
                        .padding(.trailing, .small)
                }
                .padding(.screenEdge)

                GardenDivider(weight: 2)
                    .ignoresSafeArea()

                ProductInfo(viewModel: .init(
                    name: viewModel.productName,
                    description: viewModel.description,
                    price: viewModel.price,
                    seller: viewModel.seller
                ))
                    .padding(.screenEdge)
            }
        }
        .frame(height: 300)
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
        seller: "Seller Person",
        images: ["testimage1", "testimage2", "testimage3", "testimage4"]
    )
}