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
