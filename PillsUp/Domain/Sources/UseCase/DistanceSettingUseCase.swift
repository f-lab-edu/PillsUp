//
//  File.swift
//  
//
//  Created by Junyoung on 9/5/24.
//

import Foundation

enum DistanceSettingError: Error {
    case distanceTooSmall // 100m 미만일 때
    case distanceTooLarge // 500m 초과일 때
    case distanceNotMultipleOfHundred // 100단위로 끊어지지 않을 때
}

public protocol DistanceSettingUseCase {
    func retrieve() -> Int
    func save(_ distance: Int) throws
}

public struct DistanceSetting: DistanceSettingUseCase {
    
    private let appDataRepository: AppDataRepository
    
    public init(appDataRepository: AppDataRepository) {
        self.appDataRepository = appDataRepository
    }
    
    public func retrieve() -> Int {
        appDataRepository.getDistance()
    }
    
    public func save(_ distance: Int) throws {
        if distance < 100 {
            throw DistanceSettingError.distanceTooSmall
        } else if distance > 500 {
            throw DistanceSettingError.distanceTooLarge
        } else if distance % 100 != 0 {
            throw DistanceSettingError.distanceNotMultipleOfHundred
        }
        appDataRepository.setDistance(distance)
    }
}
