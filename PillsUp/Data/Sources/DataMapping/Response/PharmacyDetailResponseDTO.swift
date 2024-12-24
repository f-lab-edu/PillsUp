//
//  File.swift
//
//
//  Created by Junyoung on 9/26/24.
//

import Foundation
import Domain

public struct PharmacyDetailResponseDTO: Decodable {
    let items: [PharmacyDetailDTO]
    let numOfRows: String?
    let pageNo: String?
    let totalCount: String?
}

public struct PharmacyDetailDTO: Decodable {
    let dutyAddr: String        // 약국 주소
    let dutyName: String        // 약국 이름
    let dutyTel1: String        // 약국 전화번호
    let dutyTime1s: String      // 월요일 시작 시간
    let dutyTime1c: String      // 월요일 종료 시간
    let dutyTime2s: String      // 화요일 시작 시간
    let dutyTime2c: String      // 화요일 종료 시간
    let dutyTime3s: String      // 수요일 시작 시간
    let dutyTime3c: String      // 수요일 종료 시간
    let dutyTime4s: String      // 목요일 시작 시간
    let dutyTime4c: String      // 목요일 종료 시간
    let dutyTime5s: String      // 금요일 시작 시간
    let dutyTime5c: String      // 금요일 종료 시간
    let dutyTime6s: String      // 토요일 시작 시간
    let dutyTime6c: String      // 토요일 종료 시간
    let dutyTime7s: String      // 일요일 시작 시간
    let dutyTime7c: String      // 일요일 종료 시간
    let dutyTime8s: String?      // 공휴일 시작 시간
    let dutyTime8c: String?      // 공휴일 종료 시간
    let hpid: String            // 병원 ID
    let postCdn1: String        // 우편번호 앞자리
    let postCdn2: String        // 우편번호 뒷자리
    let wgs84Lat: String        // 위도
    let wgs84Lon: String        // 경도
}

extension PharmacyDetailResponseDTO {
    func toDomain() -> PharmacyDetail? {
        guard let item = self.items.first else {
            return nil
        }

        return PharmacyDetail(
            dutyAddr: item.dutyAddr,
            dutyName: item.dutyName,
            dutyTel: item.dutyTel1,
            dutyTimes: [
                DutyTime(weekDay: .monday, start: item.dutyTime1s, end: item.dutyTime1c),
                DutyTime(weekDay: .tuesday, start: item.dutyTime2s, end: item.dutyTime2c),
                DutyTime(weekDay: .wednesday, start: item.dutyTime3s, end: item.dutyTime3c),
                DutyTime(weekDay: .thursday, start: item.dutyTime4s, end: item.dutyTime4c),
                DutyTime(weekDay: .friday, start: item.dutyTime5s, end: item.dutyTime5c),
                DutyTime(weekDay: .saturday, start: item.dutyTime6s, end: item.dutyTime6c),
                DutyTime(weekDay: .sunday, start: item.dutyTime7s, end: item.dutyTime7c),
                DutyTime(weekDay: .holiday, start: item.dutyTime8s, end: item.dutyTime8c)
            ],
            hpid: item.hpid,
            postCode: item.postCdn1 + item.postCdn2,
            lat: item.wgs84Lat,
            log: item.wgs84Lon
        )
    }
}
