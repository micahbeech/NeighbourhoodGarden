//
//  GardenImage.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI

// MARK: View

struct GardenImage: View {
    let imageUrl: String
    let size: CGFloat?

    var body: some View {
        // FIX ME: Temporary Implementation
        if let size = size {
            GardenIcon.lettuce
                    .resizable()
                    .frame(width: size, height: size)
                    .clipShape(
                        RoundedRectangle(cornerRadius: .cornerRadius)
                    )
        } else {
            GardenIcon.lettuce // FIX ME
                    .resizable()
                    .scaledToFit()
                    .clipShape(
                        RoundedRectangle(cornerRadius: .cornerRadius)
                    )
        }
    }
}

// MARK: Previews

struct GardenImage_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            GardenImage(imageUrl: "testimage", size: nil)
        }
    }
}
