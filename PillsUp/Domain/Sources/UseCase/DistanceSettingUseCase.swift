//
//  File.swift
//  
//
//  Created by Junyoung on 9/5/24.
//

import Foundation

public protocol DistanceSettingUseCase {
    func retrieve() -> Int
    func save(_ distance: Int)
}

public struct DistanceSetting: DistanceSettingUseCase {
    
    private let appDataRepository: AppDataRepository
    
    public init(appDataRepository: AppDataRepository) {
        self.appDataRepository = appDataRepository
    }
    
    public func retrieve() -> Int {
        appDataRepository.getDistance()
    }
    
    public func save(_ distance: Int) {
        appDataRepository.setDistance(distance)
    }
}
