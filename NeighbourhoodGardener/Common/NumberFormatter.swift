//
//  NumberFormatter.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-31.
//

import Foundation

extension NumberFormatter {
    // Assume dollars for now
    func string(from money: Money) -> String? {
        usesGroupingSeparator = true
        numberStyle = .currency
        locale = Locale.current
        let amount = Double(money.amountMinor) / 100
        return string(from: amount as NSNumber)
    }
}
