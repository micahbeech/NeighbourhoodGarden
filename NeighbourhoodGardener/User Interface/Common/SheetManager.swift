//
//  SheetManager.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-08.
//

import SwiftUI

// MARK: GardenSheet

enum GardenSheet: DefaultIdentifiable {
    case addListing
}

// MARK: SheetManager

final class SheetManager: ObservableObject {
    static let shared = SheetManager()
    @Published var activeSheet: GardenSheet?
}

// MARK: registerSheets

extension View {
    func registerSheets(activeSheet: Binding<GardenSheet?>) -> some View {
        self.sheet(item: activeSheet) { sheet in
            switch sheet {
            case .addListing:
                AddListingView(onAdd: { activeSheet.wrappedValue = nil })
            }
        }
    }
}
