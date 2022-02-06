//
//  NumberFormatter.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-31.
//

import Foundation

final class CurrencyFormatter: NumberFormatter {
    override init() {
        super.init()
        usesGroupingSeparator = true
        numberStyle = .currency
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func string(from money: Money) -> String? {
        // Assume dollars for now, fix to support other locales
        let amount = Double(money.amountMinor) / 100
        return string(from: amount as NSNumber)
    }
}
