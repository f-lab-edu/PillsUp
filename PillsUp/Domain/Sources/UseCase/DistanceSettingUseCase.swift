//
//  File.swift
//  
//
//  Created by Junyoung on 9/5/24.
//

import Foundation

enum DistanceSettingError: Error {
    case tooSmall // 100m 미만일 때
    case tooLarge // 500m 초과일 때
    case roundFigure // 100단위로 끊어지지 않을 때
}

public protocol DistanceSettingUseCase {
    func retrieve() -> Int
    func save(_ distance: Int) throws
}

public struct DistanceSetting: DistanceSettingUseCase {
    
    private let distanceRepository: DistanceSettingRepository
    
    public init(distanceRepository: DistanceSettingRepository) {
        self.distanceRepository = distanceRepository
    }
    
    public func retrieve() -> Int {
        distanceRepository.retrieve()
    }
    
    public func save(_ distance: Int) throws {
        if distance < 100 {
            throw DistanceSettingError.tooSmall
        } else if distance > 500 {
            throw DistanceSettingError.tooLarge
        } else if distance % 100 != 0 {
            throw DistanceSettingError.roundFigure
        }
        distanceRepository.save(distance)
    }
}
