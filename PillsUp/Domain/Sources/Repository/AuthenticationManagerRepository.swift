//
//  AuthenticationManagerRepository.swift
//
//
//  Created by Junyoung on 10/2/24.
//

import Foundation

public protocol AuthenticationManagerRepository {
    /// 인증된 유저 확인
    func isUserAuthenticated() async throws -> Bool

    /// 인증 데이터 저장
    func save(_ data: String) async throws

    /// 저장된 인증 데이터 삭제
    func delete() async throws
}
