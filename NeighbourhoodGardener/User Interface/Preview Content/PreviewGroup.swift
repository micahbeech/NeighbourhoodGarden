//
//  PreviewGroup.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI

struct PreviewGroup<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        Group {
            content
                .previewDisplayName("Light")
                .preferredColorScheme(.light)
                .previewInterfaceOrientation(.portrait)
                .previewDevice(.init(stringLiteral: "iPhone 13"))

            content
                .previewDisplayName("Dark")
                .preferredColorScheme(.dark)
                .previewInterfaceOrientation(.portrait)
                .previewDevice(.init(stringLiteral: "iPhone 13"))

            content
                .previewDisplayName("Dynamic Text")
                .preferredColorScheme(.light)
                .previewInterfaceOrientation(.portrait)
                .environment(\.dynamicTypeSize, .xxxLarge)
                .previewDevice(.init(stringLiteral: "iPhone 13"))

            content
                .previewDisplayName("Landscape")
                .preferredColorScheme(.light)
                .previewInterfaceOrientation(.landscapeRight)
                .previewDevice(.init(stringLiteral: "iPhone 13"))

            content
                .previewDisplayName("iPad")
                .preferredColorScheme(.light)
                .previewInterfaceOrientation(.portrait)
                .previewDevice(.init(stringLiteral: "iPad Pro (9.7-inch)"))
        }
    }
}

struct PreviewGroup_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            Text("Hello")
        }
    }
}
