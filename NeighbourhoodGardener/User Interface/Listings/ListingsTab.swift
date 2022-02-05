//
//  ListingsTab.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI

// MARK: View

struct ListingsTab: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Hello, Name")
                .titleStyle()

            GardenDivider(weight: 2)
                .padding(.vertical)

            TopTabView(labels: ["My Listings", "Favourites"]) {
                ListingsView()

                List {
                    Text("Favourites")
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
        }
        .padding(.top, .screenEdge)
    }
}

// MARK: Previews

struct ListingsTab_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            ListingsTab()
                .injectPreview(ListingsView.ViewModel.self)
        }
    }
}
