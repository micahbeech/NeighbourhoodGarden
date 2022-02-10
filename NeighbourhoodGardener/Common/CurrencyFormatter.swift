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

    func money(from string: String, currency: Currency) -> Money? {
        // Assume dollars for now, fix to support other locales
        guard let dollars = number(from: string) else { return nil }
        let cents = dollars.doubleValue * 100
        return Money(amountMinor: Int(cents), currency: currency)
    }
}
