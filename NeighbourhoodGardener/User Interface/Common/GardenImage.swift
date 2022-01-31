//
//  GardenImage.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI

struct GardenImage: View {
    let imageUrl: String

    var body: some View {
            Image.gardenLettuce // FIX ME
                .resizable()
                .scaledToFit()
                .clipShape(
                    RoundedRectangle(cornerRadius: .cornerRadius)
                )
    }
}

struct GardenImage_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            GardenImage(imageUrl: "testimage")
        }
    }
}
