//
//  ContentView.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeTab(products: [])
                .tabItem(label: L10n.Tab.home, image: "house")

            ListingsTab()
                .tabItem(label: L10n.Tab.listings, image: "leaf")

            AccountTab()
                .tabItem(label: L10n.Tab.account, image: "person.crop.circle")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewGroup {
            MainView()
        }
    }
}

extension View {
    func tabItem(label: String, image: String) -> some View {
        return self.tabItem {
            VStack {
                Image(systemName: image)
                Text(label)
            }
        }
    }
}
