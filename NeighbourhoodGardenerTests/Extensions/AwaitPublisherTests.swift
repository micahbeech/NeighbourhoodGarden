//
//  AwaitPublisherTests.swift
//  NeighbourhoodGardenerTests
//
//  Created by Micah Beech on 2022-02-07.
//

import XCTest
import Combine
import SwiftyMocky

final class AwaitPublisherTests: XCTestCase {
    func testAwaitOne() throws {
        let element = try awaitOne(Just("Single element"))
        XCTAssertEqual(element, "Single element")
    }

    func testAwaitOneSuccessObservableObject() throws {
        let observable = MockObservable()
        let element = try awaitOne(observable.$data)
        XCTAssertEqual(element, 0)
    }

    func testAwaitNth() throws {
        let element = try awaitNth(Range(0...3).publisher, 2)
        XCTAssertEqual(element, 2)
    }

    func testAwaitN() throws {
        let elements = try awaitN(Range(0...7).publisher, 3)
        XCTAssertEqual(elements.count, 3)
        elements.enumerated().forEach { (index, element) in
            XCTAssertEqual(index, element)
        }
    }

    func testAwaitAll() throws {
        let elements = try awaitAll(Range(0...7).publisher)
        XCTAssertEqual(elements.count, 8)
        elements.enumerated().forEach { (index, element) in
            XCTAssertEqual(index, element)
        }
    }

    func testAwaitError() throws {
        let fail = Fail(outputType: Void.self, failure: MyError.any)
        let error = try awaitError(fail)
        XCTAssertEqual(error, MyError.any)
    }

    func testAwaitFailure() throws {
        let publisher = Fail(outputType: String.self, failure: MyError.any)
        XCTAssertThrowsError(try awaitOne(publisher))
    }

    func testAwaitErrorFailure() throws {
        XCTAssertThrowsError(try awaitError(Just("element")))
    }
}

private final class MockObservable: ObservableObject {
    @Published var data = 0
}

private enum MyError: Error {
    case any
}
