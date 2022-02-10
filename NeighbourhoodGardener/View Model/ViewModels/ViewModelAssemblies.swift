//
//  ViewModelAssemblies.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-31.
//

import Foundation
import Swinject

var ViewModelAssemblies: [Assembly] = [
    HomeViewModelAssembly(),
    ListingsViewModelAssembly(),
    AddListingViewModelAssembly()
]
