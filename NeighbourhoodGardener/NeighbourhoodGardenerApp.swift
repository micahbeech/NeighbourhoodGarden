//
//  NeighbourhoodGardenerApp.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-30.
//

import SwiftUI

@main
struct NeighbourhoodGardenerApp: App {
    private let assembler = GardenAssembler()

    var body: some Scene {
        WindowGroup {
            assembler.resolver.resolve(MainView.self)
        }
    }
}
