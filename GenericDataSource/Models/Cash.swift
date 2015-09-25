//
//  Cash.swift
//  GenericDataSource
//
//  Created by Alan Skipp on 25/09/2015.
//  Copyright © 2015 Alan Skipp. All rights reserved.
//

import Foundation

enum Currency: String { case AUD, CAD, CHF, EUR, GBP, JPY, USD }

struct Cash { let amount: Int, currency: Currency }

extension Cash: CustomStringConvertible {
    var description: String {
        let f = NSNumberFormatter()
        f.numberStyle = .CurrencyStyle
        f.currencyCode = currency.rawValue
        return f.stringFromNumber(amount)!
    }
}
