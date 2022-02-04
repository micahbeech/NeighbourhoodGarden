//
//  GenericViewModel.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-31.
//

import Foundation
import Combine

// MARK: ViewModel

protocol ViewModel: ObservableObject where ObjectWillChangePublisher.Output == Void {
    associatedtype State
    associatedtype Event

    var state: State { get }
    func trigger(_ event: Event)
}

extension ViewModel {
    func eraseToAnyViewModel() -> AnyViewModel<State, Event> { AnyViewModel(self) }
}

extension ViewModel where Event == Never {
    func trigger(_ event: Event) {}
}

// MARK: AnyViewModel

final class AnyViewModel<State, Event>: ViewModel {
    let objectWillChange: AnyPublisher<Void, Never>

    private let wrappedState: () -> State
    private let wrappedTrigger: (Event) -> Void

    var state: State { wrappedState() }

    func trigger(_ event: Event) { wrappedTrigger(event) }

    init<V: ViewModel>(_ viewModel: V) where V.State == State, V.Event == Event {
        self.objectWillChange = viewModel.objectWillChange.eraseToAnyPublisher()
        self.wrappedState = { viewModel.state }
        self.wrappedTrigger = viewModel.trigger
    }

    /// Use for previews only.
    init(state: State) {
        self.objectWillChange = PassthroughSubject().eraseToAnyPublisher()
        self.wrappedState = { state }
        self.wrappedTrigger = { _ in }
    }
}

extension AnyViewModel: Identifiable where State: Identifiable {
    var id: State.ID { state.id }
}
