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
        switch self {
        case .getNearbyPlaces(let request):
            let baseURL = Configuration.retrieve(.baseURL)
            let serviceKey = Configuration.retrieve(.serviceKey)
            
            return URL(
                string: "\(baseURL)/B552657/ErmctInsttInfoInqireService/getParmacyLcinfoInqire?serviceKey=\(serviceKey)&WGS84_LAT=\(request.lat)&WGS84_LON=\(request.lng)"
            )!
        }
    }
    
    var path: String {
        switch self {
        case .getNearbyPlaces:
            return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getNearbyPlaces:
            return .requestPlain
            
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
