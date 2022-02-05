//
//  IdentifiableViewModel.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-31.
//

import Foundation

protocol DefaultIdentifiable: Identifiable, Equatable {}

extension DefaultIdentifiable {
    var id: UUID { UUID() }

    static func == (lhs: Self, rhs: Self) -> Bool { lhs.id == rhs.id }
}
