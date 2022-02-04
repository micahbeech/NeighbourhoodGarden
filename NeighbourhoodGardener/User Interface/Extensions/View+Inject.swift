//
//  View+Inject.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-04.
//

import SwiftUI
import Swinject

protocol StatePreviewable {
    static var preview: Self { get }
}

extension View {
    /// Injects type T as an environmentObject into the current context.
    /// Will cause a fatal error if T is not a registered type.
    func inject<T>(_ type: T.Type) -> some View where T: ObservableObject {
        self.environmentObject(GardenAssembler.shared.resolver.resolve(type)!)
    }

    /// Injects type T as an environmentObject into the current context.
    func injectPreview<T>(_ type: T.Type) -> some View where T: ViewModel, T.State: StatePreviewable {
        self.environmentObject(AnyViewModel<T.State, T.Event>(state: T.State.preview))
    }
}
