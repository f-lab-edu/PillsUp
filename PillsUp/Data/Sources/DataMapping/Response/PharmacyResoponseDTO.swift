//
//  File.swift
//  
//
//  Created by Junyoung on 9/14/24.
//

import Foundation
import Domain

// MARK: - PharmacyDTO
public struct PharmacyResoponseDTO: Decodable {
    let items: [PharmacyDTO]
    let numOfRows: String?
    let pageNo: String?
    let totalCount: String?
}

extension PharmacyResoponseDTO {
    func toDomain() -> PharmacyResponse {
        return PharmacyResponse(
            items: self.items.map { $0.toDomain() },
            numOfRows: self.numOfRows,
            pageNo: self.pageNo,
            totalCount: self.totalCount
        )
    }
}

// MARK: - PharmacyDTO
public struct PharmacyDTO: Decodable {
    let cnt: String
    let distance: String
    let dutyAddr: String
    let dutyDiv: String
    let dutyDivName: String
    let dutyName: String
    let dutyTel1: String
    let endTime: String
    let hpid: String
    let latitude: String
    let longitude: String
    let rnum: String
    let startTime: String
}

extension PharmacyDTO {
    func toDomain() -> Pharmacy {
        return Pharmacy(
            cnt: self.cnt,
            distance: self.distance,
            dutyAddr: self.dutyAddr,
            dutyDiv: self.dutyDiv,
            dutyDivName: self.dutyDivName,
            dutyName: self.dutyName,
            dutyTel1: self.dutyTel1,
            endTime: self.endTime,
            hpid: self.hpid,
            latitude: self.latitude,
            longitude: self.longitude,
            rnum: self.rnum,
            startTime: self.startTime
        )
    }
}
