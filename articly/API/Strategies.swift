//
//  Strategies.swift
//  articly
//
//  Created by Arutyun Enfendzhyan on 21.01.23.
//

import Foundation
import BetterCodable

/// Strategy to parse 'MM/dd/yyyy' into date
struct DateOnlyStrategy: DateValueCodableStrategy {
    static let dateFormat = "MM/dd/yyyy"
    
    static func decode(_ string: String) throws -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        guard let date = formatter.date(from: string) else { throw Errors.invalidDateFormat(string) }
        return date
    }

    static func encode(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
    
    enum Errors: Equatable, Error {
        case invalidDateFormat(String)
    }
}
