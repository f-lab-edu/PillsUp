//
//  Configuration.swift
//
//
//  Created by Junyoung on 9/15/24.
//

import Foundation

public enum ConfigurationKey: String {
    case serviceKey
    case baseURL
}

public struct Configuration {

    public static func retrieve(_ key: ConfigurationKey) -> String {
        guard let path = Bundle.main.path(forResource: "Configuration", ofType: "plist") else { return "" }
        guard let plistData = NSDictionary(contentsOfFile: path) as? [String: String] else { return "" }
        return plistData[key.rawValue] ?? ""

    }
}
