//
//  HomeViewModelTests.swift
//  NeighbourhoodGardenerTests
//
//  Created by Micah Beech on 2022-01-30.
//

import XCTest
import Combine
@testable import NeighbourhoodGardener

final class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel!
    var productServiceMock: ProductServiceMock!

    override func setUp() {
        productServiceMock = ProductServiceMock()
    }

    func initSut() {
        sut = HomeViewModel(productService: productServiceMock)
    }

    func testInitEmpty() throws {
        productServiceMock.given(.getProducts(willReturn: Empty().eraseToAnyPublisher()))
        initSut()

        let state = try awaitOne(sut.$state)
        XCTAssertEqual(state.products.count, 0)
    }

    func testInitProductsRetrieved() throws {
        let productPublisher = createTestProductPublisher("Product 1", "Product 2")
        productServiceMock.given(.getProducts(willReturn: productPublisher))
        initSut()

        let state = try awaitOne(sut.$state.dropFirst())
        XCTAssertEqual(state.products.count, 2)

        let firstProduct = state.products[0]
        XCTAssertEqual(firstProduct.productName, "Product 1")
        XCTAssertEqual(firstProduct.description, "This is a product named Product 1")
        XCTAssertEqual(firstProduct.seller, "seller of Product 1")
        XCTAssertEqual(firstProduct.price, "$4.00")
        XCTAssertEqual(firstProduct.imageUrl, "testimageProduct 1")

        let secondProduct = state.products[1]
        XCTAssertEqual(secondProduct.productName, "Product 2")
        XCTAssertEqual(secondProduct.description, "This is a product named Product 2")
        XCTAssertEqual(secondProduct.seller, "seller of Product 2")
        XCTAssertEqual(secondProduct.price, "$4.00")
        XCTAssertEqual(secondProduct.imageUrl, "testimageProduct 2")
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
