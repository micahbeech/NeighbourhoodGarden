//
//  Text.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI

extension Text {
    func primaryStyle() -> some View {
        return self
            .font(.avenirMedium(.mediumLarge))
            .foregroundColor(.gardenPrimarylabel)
    }

    func secondaryStyle() -> some View {
        return self
            .font(.avenirMedium(.medium))
            .foregroundColor(.gardenSecondarylabel)
    }

    func tertiaryStyle() -> some View {
        return self
            .font(.avenirMedium(.small))
            .foregroundColor(.gardenTertiarylabel)
    }
}

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
