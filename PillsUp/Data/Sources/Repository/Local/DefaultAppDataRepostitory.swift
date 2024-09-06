//
//  File.swift
//  
//
//  Created by Junyoung on 9/5/24.
//

import Domain

public struct DefaultAppDataRepostitory: AppDataRepository {
    public init() { }
    
    public func getDistance() -> Int {
        AppData.distance
    }
    
    public func setDistance(_ distance: Int) {
        AppData.distance = distance
    }
}
