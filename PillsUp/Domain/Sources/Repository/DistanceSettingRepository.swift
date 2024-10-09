//
//  File.swift
//
//
//  Created by Junyoung on 9/5/24.
//

import Foundation

public protocol DistanceSettingRepository {
    func retrieve() -> Int
    func save(_ distance: Int)
}

final class MockAppDataRepository: DistanceSettingRepository {

    var distance: Int = 500

    func retrieve() -> Int {
        return distance
    }

    func save(_ distance: Int) {
        self.distance = distance
    }
}
