//
//  AlertManager.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-09.
//

import SwiftUI

// MARK: AlertManager

final class AlertManager: ObservableObject {
    static let shared = AlertManager()
    @Published var showErrorAlert = false
}

// MARK: RegisterErrorAlert

extension View {
    func registerErrorAlert(isShowing: Binding<Bool>) -> some View {
        self.alert(L10n.Alert.Error.title, isPresented: isShowing) {
                Text(L10n.Alert.Error.confirmation).primaryStyle()
            } message: {
                Text(L10n.Alert.Error.message).secondaryStyle()
            }
    }
}
