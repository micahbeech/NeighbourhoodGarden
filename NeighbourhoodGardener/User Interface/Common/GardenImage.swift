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
        GardenIcon.lettuce
                .resizable()
                .if(size == nil) {
                    $0.scaledToFit()
                } else: {
                    $0.frame(width: size, height: size)
                }
                .clipShape(RoundedRectangle(cornerRadius: .cornerRadius))
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
