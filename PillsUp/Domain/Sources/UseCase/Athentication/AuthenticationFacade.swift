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

    private let checkUseCase: CheckAuthenticationUseCase
    private let registerUseCase: RegisterAuthenticationUseCase
    private let removeUseCase: RemoveAuthenticationUseCase

    public init(
        checkUseCase: CheckAuthenticationUseCase,
        registerUseCase: RegisterAuthenticationUseCase,
        removeUseCase: RemoveAuthenticationUseCase
    ) {
        self.checkUseCase = checkUseCase
        self.registerUseCase = registerUseCase
        self.removeUseCase = removeUseCase
    }

    public func check() async throws -> Bool {
        try await checkUseCase.exectue()
    }

    public func register(data: String) async throws {
        try await registerUseCase.execute(data: data)
    }

    public func remove() async throws {
        try await removeUseCase.execute()
    }
}
