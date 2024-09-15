//
//  XmlParser.swift
//
//
//  Created by Junyoung on 9/13/24.
//

import Foundation

final class XmlParser: NSObject, XMLParserDelegate {
    typealias ItemTypes = [String: Any]
    
    private var currentElement = ""
    private var currentValue: String?
    
    private var currentItem: ItemTypes?
    private var items = [ItemTypes]()
    
    private var isParsingBody = false
    private var bodyData = ItemTypes()
    
    // XMLParser의 델리게이트 메서드 호출 시작
    func parse(data: Data) -> [String: Any] {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return bodyData
    }
    
    // XML 태그 시작
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String: String] = [:]
    ) {
        currentElement = elementName
        currentValue = ""
        
        // body 태그가 시작되면 파싱을 시작
        if elementName == "body" {
            isParsingBody = true
        }
        
        // item 태그가 시작되면 새로운 아이템 초기화
        if isParsingBody && elementName == "item" {
            currentItem = [:]
        }
    }
    
    // XML 태그 내의 값
    func parser(
        _ parser: XMLParser,
        foundCharacters string: String
    ) {
        currentValue? += string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // XML 태그 끝
    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        // body 태그 내부를 파싱할 때만 데이터를 저장
        if isParsingBody {
            if let value = currentValue, !value.isEmpty {
                if elementName == "item" {
                    // 하나의 item이 끝날 때 items 배열에 추가
                    if let currentItem = currentItem {
                        items.append(currentItem)
                    }
                    currentItem = nil
                } else if currentItem != nil {
                    // item 내부의 key-value 추가
                    currentItem?[elementName] = value
                } else {
                    // item 외부의 데이터를 bodyData에 저장 (numOfRows, pageNo, totalCount 등)
                    bodyData[elementName] = value
                }
            }
            
            // items가 끝날 때 items 배열을 저장
            if elementName == "items" {
                bodyData["items"] = items
                items = []  // 다음 items를 위해 초기화
            }
            
            // body 태그가 끝나면 파싱을 종료
            if elementName == "body" {
                isParsingBody = false
            }
        }
    }
}

extension Data {
    func xmlToBodyJSON() throws -> Data {
        let parser = XmlParser()
        let dictionary = parser.parse(data: self)
        
        let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        
        return jsonData
    }
}
