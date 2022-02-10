//
//  NeighbourhoodGardenerApp.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI

@main
struct NeighbourhoodGardenerApp: App {
    @ObservedObject var sheetManager = SheetManager.shared
    @ObservedObject var alertManager = AlertManager.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .registerErrorAlert(isShowing: $alertManager.showErrorAlert)
                .registerSheets(activeSheet: $sheetManager.activeSheet)
                .inject(HomeTab.ViewModel.self)
                .inject(ListingsView.ViewModel.self)
                .inject(AddListingView.ViewModel.self)
                .environmentObject(sheetManager)
        }
    }
}
