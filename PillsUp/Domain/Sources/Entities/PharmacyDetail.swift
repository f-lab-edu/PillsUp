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
    public let dutyAddr: String
    public let dutyName: String
    public let dutyTel: String
    public let dutyTimes: [DutyTime]
    public let hpid: String
    public let postCode: String
    public let lat: String
    public let lng: String

    public init(
        dutyAddr: String,
        dutyName: String,
        dutyTel: String,
        dutyTimes: [DutyTime],
        hpid: String,
        postCode: String,
        lat: String,
        log: String
    ) {
        self.dutyAddr = dutyAddr
        self.dutyName = dutyName
        self.dutyTel = dutyTel
        self.dutyTimes = dutyTimes
        self.hpid = hpid
        self.postCode = postCode
        self.lat = lat
        self.lng = log
    }
}
