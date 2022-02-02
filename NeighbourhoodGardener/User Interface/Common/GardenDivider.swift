//
//  GardenDivider.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-01.
//

import SwiftUI

// MARK: View

struct GardenDivider: View {
    let weight: CGFloat
    let direction: Axis.Set

    init(weight: CGFloat = 0.4, direction: Axis.Set = .horizontal) {
        self.weight = weight
        self.direction = direction
    }

    var body: some View {
        Rectangle()
            .fill(Color.gardenDivider)
            .if(direction == .vertical) {
                $0.frame(width: weight).edgesIgnoringSafeArea(.vertical)
            } else: {
                $0.frame(height: weight).edgesIgnoringSafeArea(.horizontal)
            }
    }
}

// MARK: Previews

struct GardenDivider_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            ZStack {
                VStack(spacing: .extraLarge) {
                    GardenDivider()
                    GardenDivider(weight: 2)
                    GardenDivider(weight: 10)
                }

                HStack(spacing: .extraLarge) {
                    GardenDivider(direction: .vertical)
                    GardenDivider(weight: 5, direction: .vertical)
                }
            }
        }
    }
}
