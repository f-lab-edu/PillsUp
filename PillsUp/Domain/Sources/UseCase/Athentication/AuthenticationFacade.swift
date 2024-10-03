//
//  File.swift
//  
//
//  Created by Junyoung on 10/3/24.
//

import Foundation

public protocol AuthenticationFacade {
    func check() async throws -> Bool
    func register(data: String) async throws
    func remove() async throws
}

public final class AppleAuthentication: AuthenticationFacade {
    
    private let checkAuthenticationUseCase: CheckAuthenticationUseCase
    private let registerAuthenticationUseCase: RegisterAuthenticationUseCase
    private let removeAuthenticationUseCase: RemoveAuthenticationUseCase
    
    public init(
        checkAuthenticationUseCase: CheckAuthenticationUseCase,
        registerAuthenticationUseCase: RegisterAuthenticationUseCase,
        removeAuthenticationUseCase: RemoveAuthenticationUseCase
    ) {
        self.checkAuthenticationUseCase = checkAuthenticationUseCase
        self.registerAuthenticationUseCase = registerAuthenticationUseCase
        self.removeAuthenticationUseCase = removeAuthenticationUseCase
    }
    
    public func check() async throws -> Bool {
        try await checkAuthenticationUseCase.exectue()
    }
    
    public func register(data: String) async throws {
        try await registerAuthenticationUseCase.execute(data: data)
    }
    
    public func remove() async throws {
        try await removeAuthenticationUseCase.execute()
    }
}
