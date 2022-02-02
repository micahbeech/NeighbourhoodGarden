//
//  GardenPicker.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-01.
//

import SwiftUI

// MARK: View

struct GardenPicker: View {
    @Binding var selection: Int
    let labels: [String]

    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .top, spacing: .zero) {
                ForEach(Array(labels.enumerated()), id: \.0) { index, label in
                    Button {
                        selection = index
                    } label: {
                        VStack(spacing: .extraSmall) {
                            Text(label)
                                .if(selection == index) {
                                    $0.boldStyle()
                                } else: {
                                    $0.primaryStyle()
                                }

                            if selection == index {
                                Rectangle()
                                    .fill(Color.gardenPrimarylabel)
                                    .frame(height: 2)
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: geometry.size.width / CGFloat(labels.count))

                    Spacer()
                }
            }
        }
        .frame(height: 40)
    }
}

// MARK: Previews

private struct PreviewHelper: View {
    @State private var firstSelection = 0
    @State private var secondSelection = 0
    @State private var thirdSelection = 0
    let labels = ["Option 1", "Option 2", "Option 3", "Option 4"]

    var body: some View {
        VStack {
            GardenPicker(selection: $firstSelection, labels: Array(labels[0...1]))
            GardenPicker(selection: $secondSelection, labels: Array(labels[0...2]))
            GardenPicker(selection: $thirdSelection, labels: Array(labels[0...3]))
        }
    }
}

struct GardenPicker_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            PreviewHelper()
                .previewLayout(.fixed(width: 500, height: 200))
        }
    }
}
