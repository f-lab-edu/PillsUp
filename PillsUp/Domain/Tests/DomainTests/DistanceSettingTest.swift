//
//  DistanceSettingTest.swift
//
//
//  Created by Junyoung on 9/6/24.
//

import XCTest
@testable import Domain

final class DistanceSettingTest: XCTestCase {
    
    private var distanceSettingUseCase: DistanceSettingUseCase!
    private var mockAppDataRepository: AppDataRepository!
    
    override func setUpWithError() throws {
        mockAppDataRepository = MockAppDataRepository()
        distanceSettingUseCase = DistanceSetting(appDataRepository: mockAppDataRepository)
    }
    
    func test_500초과거리입력() {
        XCTAssertThrowsError(try distanceSettingUseCase.save(600)) { error in
            XCTAssertEqual(
                error as? DistanceSettingError,
                .distanceTooLarge
            )
        }
    }
    
    func test_100미만거리입력() {
        XCTAssertThrowsError(try distanceSettingUseCase.save(99)) { error in
            XCTAssertEqual(
                error as? DistanceSettingError,
                .distanceTooSmall
            )
        }
    }
    
    func test_100으로나누어떨어지지않는거리입력() {
        XCTAssertThrowsError(try distanceSettingUseCase.save(250)) { error in
            XCTAssertEqual(
                error as? DistanceSettingError,
                .distanceNotMultipleOfHundred
            )
        }
    }
    
    func test_거리저장성공() {
        XCTAssertNoThrow(try distanceSettingUseCase.save(100))
        XCTAssertNoThrow(try distanceSettingUseCase.save(200))
        XCTAssertNoThrow(try distanceSettingUseCase.save(300))
        XCTAssertNoThrow(try distanceSettingUseCase.save(400))
        XCTAssertNoThrow(try distanceSettingUseCase.save(500))
    }
}
