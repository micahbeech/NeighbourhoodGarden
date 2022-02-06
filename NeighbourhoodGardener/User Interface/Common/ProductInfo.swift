//
//  ProduceView.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI

// MARK: ViewModel

extension ProductInfo {
    struct ViewModel {
        let name: String
        let description: String
        let price: String
        let seller: String?
    }
}

// MARK: View

struct ProductInfo: View {
    let viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: .extraSmall) {
            HStack {
                Text(viewModel.name)
                    .primaryStyle()
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                Spacer()

                Text(viewModel.price)
                    .primaryStyle()
                    .lineLimit(1)
            }

            Text(viewModel.description)
                .secondaryStyle()
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            if let seller = viewModel.seller {
                Spacer()

                Text(L10n.Produce.soldBy(seller))
                    .tertiaryStyle()
                    .lineLimit(1)
            }
        }
    }
}

// MARK: Previews

struct ProduceInfo_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            ProductInfo(viewModel: .preview)
                .padding()
                .previewLayout(.fixed(width: 400, height: 100))
        }
    }
}

private extension ProductInfo.ViewModel {
    static let preview = Self(
        name: "Lettuce",
        description: "I am some tasty lettuce",
        price: "$4.95",
        seller: "Leafy Farmers"
    )
}
