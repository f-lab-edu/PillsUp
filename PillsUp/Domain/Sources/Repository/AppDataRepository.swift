//
//  File.swift
//  
//
//  Created by Junyoung on 9/5/24.
//

import Foundation

public protocol AppDataRepository {
    func getDistance() -> Int
    func setDistance(_ distance: Int)
}

final class MockAppDataRepository: AppDataRepository {
    
    var distance: Int = 500
    
    func getDistance() -> Int {
        return distance
    }
    
    func setDistance(_ distance: Int) {
        self.distance = distance
    }
}
