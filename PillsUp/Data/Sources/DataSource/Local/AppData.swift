//
//  File.swift
//
//
//  Created by Junyoung on 9/5/24.
//

import Foundation

enum AppData {
    enum Key: String {
        case distance
    }

    @UserDefault(key: Key.distance.rawValue, defaultValue: 500)
    static var distance: Int

    @UserDefault(key: Key.distance.rawValue, defaultValue: nil)
    static var appleUserId: String?

    @propertyWrapper
    public struct UserDefault<T> {
        private let key: String
        private let defaultValue: T

        init(key: String, defaultValue: T) {
            self.key = key
            self.defaultValue = defaultValue
        }

        public var wrappedValue: T {
            get {
                return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
            }
            set {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
}
