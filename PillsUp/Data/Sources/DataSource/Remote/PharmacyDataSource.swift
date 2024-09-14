//
//  PharmacyDataSource.swift
//
//
//  Created by Junyoung on 9/12/24.
//

import Foundation
import NetworkKit
import Moya
import Domain
import Alamofire
import Shared

public protocol PharmacyDataSource {
    func getNearbyPlaces(_ request: PharmacyRequestDTO) async throws -> PharmacyResoponseDTO
}

public final class DefaultPharmacyDataSource: PharmacyDataSource {
    private let provider: MoyaProvider<PharmacyType>
    
    public init() {
        self.provider = MoyaProvider<PharmacyType>.plain()
    }
    
    public func getNearbyPlaces(_ request: PharmacyRequestDTO) async throws -> PharmacyResoponseDTO {
        return try await provider.request(.getNearbyPlaces(request))
    }
}

enum PharmacyType {
    case getNearbyPlaces(_ request: PharmacyRequestDTO)
}

extension PharmacyType: TargetType {
    var baseURL: URL {
        return Configuration.baseUrl
    }
    
    var path: String {
        switch self {
        case .getNearbyPlaces:
            return "/B552657/ErmctInsttInfoInqireService/getParmacyLcinfoInqire"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getNearbyPlaces(let request):
            guard var query = request.asDictionary() else { return .requestPlain }
            query["serviceKey"] = "GdV6w9ttF1gQeOqShASaVgndIY4%2Fv1vT4QCAe0L1VHj7MjBwOv2I9TKmjZ56eh5keGMEHjEOGpFt5iasmTrkjQ%3D%3D"
            return .requestParameters(parameters: query, encoding: URLEncoding.default)
            
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
