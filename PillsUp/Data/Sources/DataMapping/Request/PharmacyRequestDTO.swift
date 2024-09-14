//
//  File.swift
//  
//
//  Created by Junyoung on 9/14/24.
//

import Foundation
import NetworkKit

public struct PharmacyRequestDTO: Encodable {
    let serviceKey: String = Configuration.serviceKey
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case serviceKey
        case latitude = "WGS84_LAT"
        case longitude = "WGS84_LON"
    }
}
