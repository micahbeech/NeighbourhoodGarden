//
//  CardView.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI

struct CardView<Content: View>: View {
    let content: Content

    private var cardColor: Color = .gardenBackground

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: .cornerRadius)
                .foregroundColor(cardColor)
                .shadow(color: .gardenShadow, radius: 5, x: -3, y: 0)
            content
        }
    }
}

extension CardView {
    func cardColor(_ color: Color) -> some View {
        var view = self
        view.cardColor = color
        return view
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            VStack {
                CardView {
                    Text("Content")
                }
                .frame(width: 300, height: 200)
                .padding()

                CardView {
                    Text("Content")
                }
                .frame(width: 300, height: 200)
                .padding()
            }
        }
    }
}
