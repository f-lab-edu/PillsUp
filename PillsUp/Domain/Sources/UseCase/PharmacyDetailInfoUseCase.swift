//
//  PharmacyDetailInfoUseCase.swift
//
//
//  Created by Junyoung on 9/26/24.
//

import Foundation

public protocol PharmacyDetailInfoUseCase {
    func retrieve(_ hdid: String) async throws -> PharmacyDetail?
}

public struct PharmacyDetailInfo: PharmacyDetailInfoUseCase {
    private let repository: PharmacyRepository

    public init(repository: PharmacyRepository) {
        self.repository = repository
    }

    public func retrieve(_ hpid: String) async throws -> PharmacyDetail? {
        try await repository.retrievePharmacyDetail(hpid)
    }
}
