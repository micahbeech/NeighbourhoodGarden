//
//  GardenAssembler.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-31.
//

import Foundation
import Swinject

// MARK: GardenAssembler

final class GardenAssembler {
    static let shared = GardenAssembler()

    let assembler = Assembler()
    var resolver: Resolver { assembler.resolver }

    init() {
        assembler.apply(assemblies: ViewModelAssemblies)
        assembler.apply(assemblies: ServiceAssemblies)
    }
}
