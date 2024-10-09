//
//  File.swift
//
//
//  Created by Junyoung on 9/13/24.
//

import Foundation

public protocol PharmacyRepository {
    func retrieveNearbyData(_ request: Location) async throws -> PharmacyResponse
    func retrievePharmacyDetail(_ hpid: String) async throws -> PharmacyDetail?
}
