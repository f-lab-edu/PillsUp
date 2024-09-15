//
//  File.swift
//  
//
//  Created by Junyoung on 9/14/24.
//

import Foundation
import NetworkKit

public struct PharmacyRequestDTO: Encodable {
    let lat: Double
    let lng: Double
    
    enum CodingKeys: String, CodingKey {
        case lat = "WGS84_LAT"
        case lng = "WGS84_LON"
    }
}
