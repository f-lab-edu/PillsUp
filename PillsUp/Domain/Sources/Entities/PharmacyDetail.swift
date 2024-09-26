//
//  PharmacyDetail.swift
//
//
//  Created by Junyoung on 9/26/24.
//

import Foundation

public struct PharmacyDetailResponse {
    public let items: [PharmacyDetail]
    public let numOfRows: String?
    public let pageNo: String?
    public let totalCount: String?
    
    public init(
        items: [PharmacyDetail],
        numOfRows: String?,
        pageNo: String?,
        totalCount: String?
    ) {
        self.items = items
        self.numOfRows = numOfRows
        self.pageNo = pageNo
        self.totalCount = totalCount
    }
}

public struct PharmacyDetail {
    let dutyAddr: String
    let dutyName: String
    let dutyTel: String
    let monday: DutyTime
    let tuesday: DutyTime
    let wednesday: DutyTime
    let thursday: DutyTime
    let friday: DutyTime
    let saturday: DutyTime
    let sunday: DutyTime
    let holiday: DutyTime
    let hpid: String
    let postCode: String
    let lat: String
    let log: String
    
    public init(
        dutyAddr: String,
        dutyName: String,
        dutyTel: String,
        monday: DutyTime,
        tuesday: DutyTime,
        wednesday: DutyTime,
        thursday: DutyTime,
        friday: DutyTime,
        saturday: DutyTime,
        sunday: DutyTime,
        holiday: DutyTime,
        hpid: String,
        postCode: String,
        lat: String,
        log: String
    ) {
        self.dutyAddr = dutyAddr
        self.dutyName = dutyName
        self.dutyTel = dutyTel
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
        self.sunday = sunday
        self.holiday = holiday
        self.hpid = hpid
        self.postCode = postCode
        self.lat = lat
        self.log = log
    }
}
