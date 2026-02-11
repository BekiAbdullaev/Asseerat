//
//  Item.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import Foundation

public typealias Items = [Item]
public typealias Actions = [Action]

public struct Item: Equatable, Hashable, Codable {
    public let key: String
    public let value: String
    public let id: Int?
    public let iconName: String?
    public let state: Int?
    public var currCode: String?
    public let code: String?
    public var minAmount: String?
    public var maxAmount: String?
    public let stateName: String?
    public let expandableItemType: ExpandableItemType?
    public let link: String?
    
    public init(
        key: String,
        value: String,
        id: Int? = nil,
        iconName: String? = nil,
        state: Int? = nil,
        currencyCode: String? = nil,
        code: String? = nil,
        minAmount: String? = nil,
        maxAmount: String? = nil,
        stateName: String? = nil,
        expandableItemType: ExpandableItemType? = .plain,
        link: String? = nil
    ) {
        self.key = key
        self.value = value
        self.id = id
        self.iconName = iconName
        self.state = state
        self.currCode = currencyCode
        self.code = code
        self.minAmount = minAmount
        self.maxAmount = maxAmount
        self.stateName = stateName
        self.expandableItemType = expandableItemType
        self.link = link
    }
    
    public func getAction() -> Action {
        Action(id: id ?? 0, key: key, note: value)
    }
}


public extension Items {
    func getAction() -> Actions {
        self.map { item -> Action in
            Action(id: item.id ?? 0, key: item.key, note: item.value)
        }
    }
}

public enum ExpandableItemType: Codable {
    case plain
    case link
    case phoneNo
}

public struct Action: Codable {
    public let id: Int?
    public let key, note, msg: String?
    public init(id: Int, key: String = "", note: String? = nil, msg: String? = nil) {
        self.id = id
        self.key = key
        self.note = note
        self.msg = msg
    }
}
