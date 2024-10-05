//
//  File.swift
//  
//
//  Created by Junyoung on 10/2/24.
//

import AuthenticationServices
import Foundation

import Domain

public final class AppleLoginAthenticationRepository: AuthenticationManagerRepository {
    
    public init() { }
    
    public func isUserAuthenticated() async throws -> Bool {
        guard let userId = AppData.appleUserId else { return false }
        return try await authentication(userId: userId)
    }
    
    public func saveAuthenticationData(_ data: String) async throws {
        AppData.appleUserId = data
    }
    
    public func deleteAuthenticationData() async throws {
        AppData.appleUserId = nil
    }
}

extension AppleLoginAthenticationRepository {
    func authentication(userId: String) async throws -> Bool {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        
        return try await withCheckedThrowingContinuation { continuation in
            appleIDProvider.getCredentialState(forUserID: userId) { (credentialState, error) in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                switch credentialState {
                case .authorized:
                    continuation.resume(returning: true)
                case .revoked, .notFound, .transferred:
                    continuation.resume(returning: false)
                @unknown default:
                    continuation.resume(returning: false)
                }
            }
        }
    }
}
