//
//  AddListingCard.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-08.
//

import SwiftUI

// MARK: View

struct AddListingCard: View {
    let onTap: () -> Void

    var body: some View {
        CardView {
            ZStack(alignment: .leading) {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: .mediumLarge, height: .mediumLarge)
                    .foregroundColor(.gardenSecondarylabel)

                HStack(spacing: .mediumLarge) {
                    Spacer()

                    Text(L10n.Listing.new)
                        .font(.avenirMedium(.medium))
                        .foregroundColor(.gardenSecondarylabel)

                    Spacer()
                }
            }
            .padding(.screenEdge)
        }
        .onTapGesture {
            onTap()
        }
    }
}

// MARK: Previews

struct AddListingCard_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            AddListingCard(onTap: {})
                .previewLayout(.fixed(width: 300, height: 60))
        }
    }
}
