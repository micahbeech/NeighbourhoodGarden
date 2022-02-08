//
//  RealProductServiceTests.swift
//  NeighbourhoodGardenerTests
//
//  Created by Micah Beech on 2022-02-07.
//

import XCTest
@testable import NeighbourhoodGardener

final class RealProductServiceTests: XCTestCase {
    var sut: RealProductService!

    override func setUp() {
        sut = RealProductService()
    }

    func testGetProductsReturnsProducts() throws {
        let products = try awaitOne(sut.getProducts())

        XCTAssertEqual(products.count, 3)

        let first = products[0]
        XCTAssertEqual(first.name, "Tomatoes")
        XCTAssertEqual(first.description, "Fresh, local, garden tomatoes. Grown with love")
        XCTAssertEqual(first.seller, "John Krasinski")
        XCTAssertEqual(first.price, .cad(10_00))
        XCTAssertEqual(first.imageUrls, ["1", "2"])

        let second = products[1]
        XCTAssertEqual(second.name, "Lettuce")
        XCTAssertEqual(second.description, "Crispy lettuce")
        XCTAssertEqual(second.seller, "Anastasia Applebaum")
        XCTAssertEqual(second.price, .cad(12_34))
        XCTAssertEqual(second.imageUrls, ["1", "2", "3", "4"])

        let third = products[2]
        XCTAssertEqual(third.name, "Homegrown potatoes")
        XCTAssertEqual(third.description, "Earth to mouth, these will make your mouth water.")
        XCTAssertEqual(third.seller, "Kelly Clarkson")
        XCTAssertEqual(third.price, .cad(15_95))
        XCTAssertEqual(third.imageUrls, ["1"])
    }
}
