//
//  ResponceSerialization.swift
//  ROUTE
//
//  Created by Sumit Tripathi on 23/01/18.
//  Copyright © 2018 Route. All rights reserved.
//

import Foundation

public struct ResponceSerialization {
    public let result: Serialization?
    public let list: [Serialization]?
    public let totalPages: Int64?
    public let nextPage: Int64?
    public let status_code: Int?
    public let message: String?
    public let code: Int?
}

extension ResponceSerialization: BaseModel {
    
    private enum Keys: String, SerializationKey {
        case result = "data"
        case status_code = "status"
        case message = "detail"
        case code
        case totalPages = "total_page"
        case nextPage = "next_page"
    }
    
    public init(serialization: Serialization) {
        result = serialization.value(forKey: Keys.result)
        list = serialization.value(forKey: Keys.result)
        status_code = serialization.value(forKey: Keys.status_code)
        message = serialization.value(forKey: Keys.message)
        code = serialization.value(forKey: Keys.code)
        totalPages = serialization.value(forKey: Keys.totalPages)
        nextPage = serialization.value(forKey: Keys.nextPage)
    }
}
