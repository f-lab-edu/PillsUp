//
//  RemoveAuthenticationUseCase.swift
//
//
//  Created by Junyoung on 10/3/24.
//

import Foundation

public protocol RemoveAuthenticationUseCase {
    func execute() async throws
}

public final class RemoveAppleAuthentication: RemoveAuthenticationUseCase {

    private let repository: AuthenticationManagerRepository

    public init(repository: AuthenticationManagerRepository) {
        self.repository = repository
    }

    public func execute() async throws {
        try await repository.delete()
    }
}
