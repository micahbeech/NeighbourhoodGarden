//
//  ServiceAssemblies.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-31.
//

import Foundation
import Swinject

var ServiceAssemblies: [Assembly] = [
    RealProductServiceAssembly(),
    RealGardenAPIAssembly()
]
