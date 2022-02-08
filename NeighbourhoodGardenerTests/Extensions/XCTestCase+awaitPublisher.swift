//
//  XCTestCase+awaitPublisher.swift
//  NeighbourhoodGardenerTests
//
//  Created by Micah Beech on 2022-02-07.
//

import XCTest
import Combine

// MARK: PublisherExpectationError

enum PublisherExpectationError: Error {
    case unexpectedOutput(Any)
    case unexpectedError(Error)
    case unexpectedCompletion
}

// MARK: Await Methods

// based on https://www.swiftbysundell.com/articles/unit-testing-combine-based-swift-code/
extension XCTestCase {
    func awaitOne<T: Publisher>(_ publisher: T, timeout: TimeInterval = 1) throws -> T.Output {
        try awaitNth(publisher, 0, timeout: timeout)
    }

    func awaitNth<T: Publisher>(_ publisher: T, _ n: Int, timeout: TimeInterval = 1) throws -> T.Output {
        try awaitN(publisher, n + 1, timeout: timeout)[n]
    }

    func awaitN<T: Publisher>(_ publisher: T, _ n: Int, timeout: TimeInterval = 1) throws -> [T.Output] {
        try awaitAll(publisher.collect(n).first(), timeout: timeout).first!
    }

    func awaitAll<T: Publisher>(_ publisher: T, timeout: TimeInterval = 1) throws -> [T.Output] {
        return try awaitPublisher(publisher.collect(), timeout: timeout) { error in
            .failure(.unexpectedError(error))
        } onReceive: { output in
            .success(output)
        }
    }

    func awaitError<T: Publisher>(_ publisher: T, timeout: TimeInterval = 1) throws -> T.Failure {
        try awaitPublisher(publisher, timeout: timeout) { error in
            .success(error)
        } onReceive: { output in
            .failure(.unexpectedOutput(output))
        } onCompletion: {
            .failure(.unexpectedCompletion)
        }
    }

    private func awaitPublisher<T: Publisher, Output>(
        _ publisher: T,
        timeout: TimeInterval,
        file: StaticString = #file,
        line: UInt = #line,
        onFailure: ((T.Failure) -> Result<Output, PublisherExpectationError>)? = nil,
        onReceive: ((T.Output) -> Result<Output, PublisherExpectationError>)? = nil,
        onCompletion: (() -> Result<Output, PublisherExpectationError>)? = nil
    ) throws -> Output {
        var result: Result<Output, PublisherExpectationError>?
        let expectation = expectation(description: "Awaiting publisher output")

        let cancellable = publisher.sink { completion in
            switch completion {
            case .failure(let error):
                if let newResult = onFailure?(error) { result = newResult }
            case .finished:
                if let newResult = onCompletion?() { result = newResult }
            }

            expectation.fulfill()
        } receiveValue: { output in
            if let newResult = onReceive?(output) { result = newResult }
        }

        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        let unwrappedResult = try XCTUnwrap(
            result,
            "No values published by publisher \(publisher)",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
}
