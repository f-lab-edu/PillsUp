//
//  CheckAuthenticationUseCase.swift
//
//
//  Created by Junyoung on 10/3/24.
//

import Foundation

public protocol CheckAuthenticationUseCase {
    func exectue() async throws -> Bool
}

public final class CheckAppleAuthenticationUseCase: CheckAuthenticationUseCase {

    private let repository: AuthenticationManagerRepository

    public init(repository: AuthenticationManagerRepository) {
        self.repository = repository
    }

    public func exectue() async throws -> Bool {
        try await repository.isUserAuthenticated()
    }
}
