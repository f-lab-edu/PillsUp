//
//  File.swift
//  
//
//  Created by Junyoung on 9/14/24.
//

import Foundation

public struct Location {
    public let lat: Double
    public let lng: Double
    
    public init(latitude: Double, longitude: Double) {
        self.lat = latitude
        self.lng = longitude
    }
}
