//
//  Text.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI

// MARK: Extensions

extension Text {
    func primaryStyle() -> Text {
        self
            .font(.avenirMedium(.medium))
            .foregroundColor(.gardenPrimarylabel)
    }

    func secondaryStyle() -> Text {
        self
            .font(.avenirMedium(.mediumSmall))
            .foregroundColor(.gardenSecondarylabel)
    }

    func tertiaryStyle() -> Text {
        self
            .font(.avenirMedium(.small))
            .foregroundColor(.gardenTertiarylabel)
    }

    func titleStyle() -> Text {
        self
            .font(.avenirDemiBold(.large))
            .foregroundColor(.gardenPrimarylabel)
    }

    func boldStyle(size: CGFloat = .medium) -> Text {
        self
            .font(.avenirBold(size))
            .foregroundColor(.gardenPrimarylabel)
    }
}

// MARK: Previews

struct TextStyle_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            VStack(alignment: .leading) {
                Text("I am primary text.")
                    .primaryStyle()

                Text("I am secondary text.")
                    .secondaryStyle()

                Text("I am tertiary text.")
                    .tertiaryStyle()
            }
        }
    }
}
