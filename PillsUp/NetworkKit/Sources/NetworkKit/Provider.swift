//
//  Provider.swift
//
//
//  Created by Junyoung on 9/12/24.
//

import Foundation
import Moya

public extension MoyaProvider {
    static func plain<T: TargetType>() -> MoyaProvider<T> {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        
        let session = Session(configuration: configuration)
        
        return MoyaProvider<T>(session: session)
    }
    
    func request<T: Decodable>(_ target: Target) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    guard (200...300).contains(response.statusCode) else {
                        continuation.resume(throwing: MoyaError.statusCode(response))
                        return
                    }
                    
                    do {
                        let jsonData = try response.data.xmlToBodyJSON()
                        let result = try JSONDecoder().decode(T.self, from: jsonData)
                        continuation.resume(returning: result)
                    } catch {
                        continuation.resume(throwing: MoyaError.jsonMapping(response))
                    }
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
