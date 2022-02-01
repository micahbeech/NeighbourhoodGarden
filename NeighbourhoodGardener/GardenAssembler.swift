//
//  GardenAssembler.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-31.
//

import Foundation
import Swinject

class GardenAssembler {
    let assembler = Assembler()
    var resolver: Resolver { assembler.resolver }

    init() {
        assembler.apply(assembly: ResolverAssembly())

        assembler.apply(assemblies: UserInterfaceAssemblies)
        assembler.apply(assemblies: PreviewAssemblies)
        assembler.apply(assemblies: ViewModelAssemblies)
        assembler.apply(assemblies: ServiceAssemblies)
    }
}

class ResolverAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Resolver.self, factory: { $0 }).inObjectScope(.container)
    }
}
