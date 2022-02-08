//
//  Money.swift
//  NeighbourhoodGardenerTests
//
//  Created by Micah Beech on 2022-02-07.
//

import Foundation
@testable import NeighbourhoodGardener

extension Money {
    static func of(_ amount: Int, currency: Currency) -> Money {
        .init(amountMinor: amount, currency: currency)
    }

    static func cad(_ amount: Int) -> Money {
        .of(amount, currency: .CAD)
    }

    static func usd(_ amount: Int) -> Money {
        .of(amount, currency: .USD)
    }

    static func euro(_ amount: Int) -> Money {
        .of(amount, currency: .EUR)
    }
}
