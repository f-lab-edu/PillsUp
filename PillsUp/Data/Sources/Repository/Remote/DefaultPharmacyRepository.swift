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
            latitude: request.latitude,
            longitude: request.longitude
        )
        
        return try await dataSource.getNearbyPlaces(requestDTO).toDomain()
    }
}
