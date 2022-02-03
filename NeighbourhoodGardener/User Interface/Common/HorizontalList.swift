//
//  HorizontalList.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-03.
//

import SwiftUI

// MARK: View

// This could be updated to support item selection,
// alignment, spacing, and list styling.
// Keeping the implementation simple for now.
struct HorizontalList<Content>: View where Content: View {
    private let content: Content

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: .zero) {
                content
            }
        }
    }
}

// MARK: Initializers

extension HorizontalList {
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    // Do not support the Range<Int> init since we cannot enforce
    // that the range is constant outside of the compiler

    init<Data, ID, RowContent>(
        _ data: Data,
        id: KeyPath<Data.Element, ID>,
        rowContent: @escaping (Data.Element) -> RowContent
    ) where Content == ForEach<Data, ID, RowContent>,
            Data: RandomAccessCollection,
            ID: Hashable,
            RowContent: View {
        self.content = ForEach(data, id: id) { element in
            rowContent(element)
        }
    }

    init<Data, RowContent>(
        _ data: Data,
        rowContent: @escaping (Data.Element) -> RowContent
    ) where Content == ForEach<Data, Data.Element.ID, RowContent>,
            Data: RandomAccessCollection,
            RowContent: View,
            Data.Element: Identifiable {
        self.content = ForEach(data) { element in
            rowContent(element)
        }
    }
}

// MARK: Previews

struct HorizontalList_Previews: PreviewProvider {
    static var previews: some View {
        ContentPreview()
        NonIdentifiablePreview()
        IdentifiablePreview()
    }
}

struct ContentPreview: View {
    var body: some View {
        HorizontalList {
            Text("First")
                .padding()
            Text("Second")
                .padding()
            Text("Third")
                .padding()
        }
    }
}

struct NonIdentifiablePreview: View {
    let data = ["First", "Second", "Third"]

    var body: some View {
        HorizontalList(data, id: \.self) { element in
            Text(element).padding()
        }
    }
}

struct IdentifiablePreview: View {
    struct Data: Identifiable {
        let content: String
        let id = UUID()

        init(_ content: String) {
            self.content = content
        }
    }

    let data = [Data("First"), Data("Second"), Data("Third")]

    var body: some View {
        HorizontalList(data) { element in
            Text(element.content).padding()
        }
    }
}
