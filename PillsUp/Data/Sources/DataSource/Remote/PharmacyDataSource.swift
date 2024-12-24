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
    func getDetail(_ hpid: String) async throws -> PharmacyDetailResponseDTO
}

public final class DefaultPharmacyDataSource: PharmacyDataSource {
    private let provider: MoyaProvider<PharmacyType>

    public init() {
        self.provider = MoyaProvider<PharmacyType>.plain()
    }

    public func getNearbyPlaces(_ request: PharmacyRequestDTO) async throws -> PharmacyResoponseDTO {
        return try await provider.request(.getNearbyPlaces(request))
    }

    public func getDetail(_ hpid: String) async throws -> PharmacyDetailResponseDTO {
        return try await provider.request(.getDetail(hpid))
    }
}

enum PharmacyType {
    case getNearbyPlaces(_ request: PharmacyRequestDTO)
    case getDetail(_ hpid: String)
}

extension PharmacyType: TargetType {
    var baseURL: URL {
        let baseURL = Configuration.retrieve(.baseURL)
        let serviceKey = Configuration.retrieve(.serviceKey)

        switch self {
        case .getNearbyPlaces(let request):
            return URL(
                string: "\(baseURL)/B552657/ErmctInsttInfoInqireService/getParmacyLcinfoInqire?serviceKey=\(serviceKey)&WGS84_LAT=\(request.lat)&WGS84_LON=\(request.lng)"
            )!
        case .getDetail(let hpid):
            return URL(
                string:"\(baseURL)/B552657/ErmctInsttInfoInqireService/getParmacyBassInfoInqire?serviceKey=\(serviceKey)&HPID=\(hpid)"
            )!
        }
    }

    var path: String {
        switch self {
        case .getNearbyPlaces, .getDetail:
            return ""
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Moya.Task {
        switch self {
        case .getNearbyPlaces, .getDetail:
            return .requestPlain

        }
    }

    var headers: [String: String]? {
        return nil
    }
}
