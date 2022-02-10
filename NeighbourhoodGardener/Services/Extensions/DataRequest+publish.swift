//
//  DataRequest+publish.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-02-09.
//

import Foundation
import Combine
import Alamofire

extension DataRequest {
    func publishOrAlert<ResponseType>() -> AnyPublisher<ResponseType, Never> where ResponseType: Decodable {
        self.publishDecodable(type: ResponseType.self)
            .value()
            .catch { error -> AnyPublisher<ResponseType, Never> in
                AlertManager.shared.showErrorAlert = true
                print(error.localizedDescription)
                return Empty().eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
