//
//  ContentView.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI
import Swinject

struct MainView: View {
    let homeTab: HomeTab

    var body: some View {
        TabView {
            homeTab
                .tabItem(label: L10n.Tab.home, image: "house")

            ListingsTab()
                .tabItem(label: L10n.Tab.listings, image: "leaf")

            AccountTab()
                .tabItem(label: L10n.Tab.account, image: "person.crop.circle")
        }
        .background(Color.gardenBackground)
    }
}

extension View {
    func tabItem(label: String, image: String) -> some View {
        self.tabItem {
            VStack {
                Image(systemName: image)
                Text(label)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static let mainView = GardenAssembler().resolver.resolve(MainView.self, name: "Preview")

    static var previews: some View {
        PreviewGroup { mainView }
    }
}

final class MainViewAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MainView.self) { resolver in
            let homeTab = resolver.resolve(HomeTab.self)!
            return MainView(homeTab: homeTab)
        }
    }
}

final class MainViewPreviewAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MainView.self, name: "Preview") { resolver in
            let homeTab = resolver.resolve(HomeTab.self, name: "Preview")!
            return MainView(homeTab: homeTab)
        }
    }
}
