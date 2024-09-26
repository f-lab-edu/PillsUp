//
//  File.swift
//  
//
//  Created by Junyoung on 9/13/24.
//

import Foundation
import Domain

public struct DefaultPharmacyRepository: PharmacyRepository {
    private let dataSource: PharmacyDataSource
    
    public init(dataSource: PharmacyDataSource) {
        self.dataSource = dataSource
    }
    
    public func retrieveNearbyData(_ request: Location) async throws -> PharmacyResponse {
        let requestDTO = PharmacyRequestDTO(
            lat: request.lat,
            lng: request.lng
        )
        
        return try await dataSource.getNearbyPlaces(requestDTO).toDomain()
    }
    
    public func retrievePharmacyDetail(_ hpid: String) async throws -> PharmacyDetail? {
        return try await dataSource.getDetail(hpid).toDomain()
    }
}
