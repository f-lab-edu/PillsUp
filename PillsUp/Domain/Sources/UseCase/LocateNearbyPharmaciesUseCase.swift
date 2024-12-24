//
//  File.swift
//
//
//  Created by Junyoung on 9/13/24.
//

import Foundation

public protocol LocateNearbyPharmaciesUseCase {
    func retrieve(_ request: Location) async throws -> PharmacyResponse
}

public struct LocateNearbyPharmacies: LocateNearbyPharmaciesUseCase {
    private let repository: PharmacyRepository

    public init(repository: PharmacyRepository) {
        self.repository = repository
    }

    public func retrieve(_ request: Location) async throws -> PharmacyResponse {
        try await repository.retrieveNearbyData(request)
    }
}
