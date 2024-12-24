//
//  File.swift
//
//
//  Created by Junyoung on 9/5/24.
//

import Domain

public struct DefaultDistanceSettingRepostitory: DistanceSettingRepository {
    public init() { }

    public func retrieve() -> Int {
        AppData.distance
    }

    public func save(_ distance: Int) {
        AppData.distance = distance
    }
}
