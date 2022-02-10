//
//  GardenAPI.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-07.
//

import Foundation
import Combine
import Swinject
import Alamofire

// MARK: GardenAPI

protocol GardenAPI {
    func getResource<ResourceType>(
        _ type: ResourceType.Type,
        path: String
    ) -> AnyPublisher<ResourceType, Never> where ResourceType: Decodable

    func createResource<ResourceType, ResponseType>(
        _ resource: ResourceType,
        _ response: ResponseType.Type,
        path: String
    ) -> AnyPublisher<ResponseType, Never> where ResourceType: Codable, ResponseType: Decodable
}

// MARK: RealGardenAPI

final class RealGardenAPI: GardenAPI {
    func getResource<ResourceType>(
        _ type: ResourceType.Type,
        path: String
    ) -> AnyPublisher<ResourceType, Never> where ResourceType: Decodable {
        AF.request(ApiPath(path), method: .get).publishOrAlert()
    }

    func createResource<ResourceType, ResponseType>(
        _ resource: ResourceType,
        _ response: ResponseType.Type,
        path: String
    ) -> AnyPublisher<ResponseType, Never> where ResourceType: Encodable, ResponseType: Decodable {
        AF.request(
            ApiPath(path),
            method: .post,
            parameters: resource,
            encoder: JSONParameterEncoder.prettyPrinted
        )
        .publishOrAlert()
    }
}

// MARK: RealGardenAPIAssembly

final class RealGardenAPIAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GardenAPI.self) { _ in
            RealGardenAPI()
        }
    }
}
