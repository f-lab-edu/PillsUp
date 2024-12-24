//
//  File.swift
//
//
//  Created by Junyoung on 9/14/24.
//

import Foundation

// MARK: - PharmacyResponse
public struct PharmacyResponse {
    public let items: [Pharmacy]
    public let numOfRows: String?
    public let pageNo: String?
    public let totalCount: String?

    public init(
        items: [Pharmacy],
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

// MARK: - Pharmacy
public struct Pharmacy {
    public let cnt: String
    public let distance: String
    public let dutyAddr: String
    public let dutyDiv: String
    public let dutyDivName: String
    public let dutyName: String
    public let dutyTel1: String
    public let endTime: String
    public let hpid: String
    public let latitude: String
    public let longitude: String
    public let rnum: String
    public let startTime: String

    public init(
        cnt: String,
        distance: String,
        dutyAddr: String,
        dutyDiv: String,
        dutyDivName: String,
        dutyName: String,
        dutyTel1: String,
        endTime: String,
        hpid: String,
        latitude: String,
        longitude: String,
        rnum: String,
        startTime: String
    ) {
        self.cnt = cnt
        self.distance = distance
        self.dutyAddr = dutyAddr
        self.dutyDiv = dutyDiv
        self.dutyDivName = dutyDivName
        self.dutyName = dutyName
        self.dutyTel1 = dutyTel1
        self.endTime = endTime
        self.hpid = hpid
        self.latitude = latitude
        self.longitude = longitude
        self.rnum = rnum
        self.startTime = startTime
    }
}
