//
//  File.swift
//  
//
//  Created by Junyoung on 9/13/24.
//

import Foundation

public protocol LocateNearbyPharmaciesUseCase {
    func retrieve() async throws -> Pharmacy
}

public struct LocateNearbyPharmacies: LocateNearbyPharmaciesUseCase {
    private let repository: PharmacyRepository
    
    public init(repository: PharmacyRepository) {
        self.repository = repository
    }
    
    public func retrieve() async throws -> Pharmacy {
        try await repository.retrieveNearbyData()
    }
}
