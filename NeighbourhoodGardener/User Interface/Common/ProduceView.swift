//
//  ProduceView.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI

extension ProduceView {
    struct ViewModel {
        let name: String
        let description: String
        let price: String
        let seller: String
        let imageUrl: String
    }
}

struct ProduceView: View {
    let viewModel: ViewModel

    var body: some View {
        HStack(alignment: .top, spacing: .extraSmall) {
            GardenImage(imageUrl: viewModel.imageUrl)

            VStack(alignment: .leading, spacing: .extraSmall) {
                HStack {
                    Text(viewModel.name)
                        .primaryStyle()
                        .lineLimit(1)

                    Spacer()

                    Text(viewModel.price)
                        .primaryStyle()
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }

                Text(viewModel.description)
                    .secondaryStyle()

                Spacer()

                Text(L10n.Produce.soldBy(viewModel.seller))
                    .tertiaryStyle()
                    .lineLimit(1)
            }
        }
    }
}

struct ProduceView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            ProduceView(viewModel: .preview)
                .frame(height: 100)
        }
    }
}

private extension ProduceView.ViewModel {
    static let preview = Self(
        name: "Lettuce",
        description: "I am some tasty lettuce",
        price: "$4.95",
        seller: "Leafy Farmers",
        imageUrl: "testimage"
    )
}
