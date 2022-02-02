//
//  TopTabView.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-01.
//

import SwiftUI

// MARK: View

// This could use some touching up in the future, including
// - Modifier to set tab label instead of passing array to init
// - Pass in binding to selected tab instead of using internal state
//       to allow for programmatic tab switching
// - Update GardenPicker to allow for non-text labels
struct TopTabView: View {
    @State private var selectedTab = 0
    let labels: [String]
    let content: [AnyView]

    var body: some View {
        VStack {
            GardenPicker(selection: $selectedTab, labels: labels)

            if selectedTab < content.count {
                content[selectedTab]
            }
        }
    }
}

// MARK: Initializers

extension TopTabView {
    init<C0>(
        labels: [String],
        @ViewBuilder content: () -> C0
    ) where C0: View {
        self.labels = labels
        self.content = [AnyView(content())]
    }

    init<C0, C1>(
        labels: [String],
        @ViewBuilder content: () -> TupleView<(C0, C1)>
    ) where C0: View, C1: View {
        self.labels = labels
        let views = content().value
        self.content = [AnyView(views.0), AnyView(views.1)]
    }

    init<C0, C1, C2>(
        labels: [String],
        @ViewBuilder content: () -> TupleView<(C0, C1, C2)>
    ) where C0: View, C1: View, C2: View {
        self.labels = labels
        let views = content().value
        self.content = [AnyView(views.0), AnyView(views.1), AnyView(views.2)]
    }

    init<C0, C1, C2, C3>(
        labels: [String],
        @ViewBuilder content: () -> TupleView<(C0, C1, C2, C3)>
    ) where C0: View, C1: View, C2: View, C3: View {
        self.labels = labels
        let views = content().value
        self.content = [AnyView(views.0), AnyView(views.1), AnyView(views.2), AnyView(views.3)]
    }
}

// MARK: Previews

struct TopTabView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            TopTabView(labels: ["Option 1", "Option 2"]) {
                Text("I am option 1")

                Text("I am option 2")
            }
        }
    }
}
