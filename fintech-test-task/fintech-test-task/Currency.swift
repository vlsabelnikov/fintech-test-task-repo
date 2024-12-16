//
//  Currency.swift
//  fintech-test-task
//
//  Created by Vladyslav Sabelnikov on 16.12.2024.
//

enum Currency: String, CaseIterable {
    case EUR = "EUR"
    case USD = "USD"
    case JPY = "JPY"
    case GBP = "GBP"
    case AUD = "AUD"
    case CAD = "CAD"
    case CHF = "CHF"
    case CNY = "CNY"
    case SEK = "SEK"
    case NZD = "NZD"
    
//Add case with additional currency after this line to include that currency in Picker
    
    static var allCurrencies: [String] {
        return Currency.allCases.map { $0.rawValue }
    }
}
