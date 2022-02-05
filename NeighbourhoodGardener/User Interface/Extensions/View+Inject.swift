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

typealias ObservedInject = EnvironmentObject

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

// Eventually, we should replace the above with something along the lines of the below.
// The below implementation will pass updates to the view which can be handled with onReceive,
// but it does not automatically invalidate the view so that it gets redrawn, meaning that
// published updates are not caught by the view until something else forces the view to update.
// Ideally we should figure out how to get a custom property wrapper to invalidate its view, and
// then update to using the below.

// The advantage of the below is that then we don't have to explicitly inject the dependencies into
// the top level view as environment objects, they will be injected automatically on a per-view basis.

// @propertyWrapper
// struct ObservedInject<ObjectType> where ObjectType: ObservableObject {
//    @ObservedObject var wrappedValue = GardenAssembler.shared.resolver.resolve(ObjectType.self)!
//
//    var projectedValue: ObservedObject<ObjectType>.Wrapper {
//        $wrappedValue
//    }
// }
