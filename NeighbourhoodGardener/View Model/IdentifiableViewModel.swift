//
//  IdentifiableViewModel.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-31.
//

import Foundation

protocol IdentifiableViewModel: Identifiable {}

extension IdentifiableViewModel {
    var id: UUID { UUID() }
}
