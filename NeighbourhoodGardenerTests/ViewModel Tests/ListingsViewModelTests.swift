//
//  ListingsViewModelTests.swift
//  NeighbourhoodGardenerTests
//
//  Created by Micah Beech on 2022-02-07.
//

import XCTest
import Combine
@testable import NeighbourhoodGardener

class ListingsViewModelTests: XCTestCase {
    var sut: ListingsViewModel!
    var productServiceMock: ProductServiceMock!

    override func setUp() {
        productServiceMock = ProductServiceMock()
    }

    func initSut() {
        sut = ListingsViewModel(productService: productServiceMock)
    }

    func testInitEmpty() throws {
        productServiceMock.given(.getProducts(willReturn: Empty().eraseToAnyPublisher()))
        initSut()

        let state = try awaitOne(sut.$state)
        XCTAssertEqual(state.listings.count, 0)
    }

    func testInitProductsRetrieved() throws {
        let productPublisher = createTestProductPublisher("Product 1", "Product 2")
        productServiceMock.given(.getProducts(willReturn: productPublisher))
        initSut()

        let state = try awaitOne(sut.$state.dropFirst())
        XCTAssertEqual(state.listings.count, 2)

        let firstProduct = state.listings[0]
        XCTAssertEqual(firstProduct.productName, "Product 1")
        XCTAssertEqual(firstProduct.description, "This is a product named Product 1")
        XCTAssertEqual(firstProduct.price, "$4.00")
        XCTAssertEqual(firstProduct.images, ["testimageProduct 1"])

        let secondProduct = state.listings[1]
        XCTAssertEqual(secondProduct.productName, "Product 2")
        XCTAssertEqual(secondProduct.description, "This is a product named Product 2")
        XCTAssertEqual(secondProduct.price, "$4.00")
        XCTAssertEqual(secondProduct.images, ["testimageProduct 2"])
    }

    private func createTestProductPublisher(_ names: String...) -> AnyPublisher<[Product], Never> {
        let products = names.map { name in
            Product(
                name: name,
                description: "This is a product named \(name)",
                seller: "seller of \(name)",
                price: .cad(4_00),
                imageUrls: ["testimage\(name)"]
            )
        }
        return Just(products).eraseToAnyPublisher()
    }
}
