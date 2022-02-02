//
//  View+If.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-01.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<ThenType, ElseType>(
        _ condition: @autoclosure () -> Bool,
        apply: (Self) -> ThenType,
        else: (Self) -> ElseType
    ) -> some View where ThenType: View, ElseType: View {
        if condition() {
            apply(self)
        } else {
            `else`(self)
        }
    }

    @ViewBuilder
    func `if`<ThenType>(
        _ condition: @autoclosure () -> Bool,
        apply: (Self) -> ThenType
    ) -> some View where ThenType: View {
        if condition() {
            apply(self)
        } else {
            self
        }
    }
}
