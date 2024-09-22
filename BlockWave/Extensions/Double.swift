//
//  Double.swift
//  BlockWave
//
//  Created by Mohamad Farhan on 19/08/24.
//

import Foundation

extension Double {
    /// Convert double into a currency with 2-6 Decimals
    ///```
    /// Convert 1234.56 into $1,234.56
    ///```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    /// Convert double into a currency with 2-6 Decimals
    ///```
    /// Convert 1234.56 into "$1,234.56"
    ///```
    func asCurrencyWith2Decimals () -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// Convert double into a currency with 2-6 Decimals
    ///```
    /// Convert 1234.56 into "1234.56"
    ///```
    func asNumberToString () -> String {
        return String(format: "%.2f", self)
    }
    
    /// Convert double into a currency with 2-6 Decimals
    ///```
    /// Convert 14 into "14%"
    ///```
    func asPercentString () -> String {
        return asNumberToString() + "%"
    }
}
