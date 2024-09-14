//
//  File.swift
//  
//
//  Created by Junyoung on 9/13/24.
//

import Foundation

public protocol PharmacyRepository {
    func retrieveNearbyData() async throws -> Pharmacy
}
