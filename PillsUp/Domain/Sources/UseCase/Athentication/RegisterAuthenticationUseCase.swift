//
//  RegisterAuthenticationUseCase.swift
//
//
//  Created by Junyoung on 10/3/24.
//

import Foundation

public protocol RegisterAuthenticationUseCase {
    func execute(data: String) async throws
}

public final class RegisterAppleAuthentication: RegisterAuthenticationUseCase {
    
    private let repository: AuthenticationManagerRepository
    
    public init(repository: AuthenticationManagerRepository) {
        self.repository = repository
    }
    
    public func execute(data: String) async throws {
        try await repository.saveAuthenticationData(data)
    }
}
