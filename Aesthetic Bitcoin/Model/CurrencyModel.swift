//
//  CurrencyModel.swift
//  Aesthetic Bitcoin
//
//  Created by Nitish Dash on 09/02/18.
//  Copyright © 2018 Nitish Dash. All rights reserved.
//

import Foundation

class CurrencyModel {
    
    var currencyFinal = ""
    var currencyTag = 0
    var flag = "⚡️"
    
    func currencySwitcher(tag: Int) -> [String]  {
        switch tag {
        case 0:
            return ["USD", "$", "UNITED STATES DOLLARS"]
        case 1:
            return ["INR", "₹", "INDIAN RUPEE"]
        case 2:
            return ["EUR", "€", "EUROPEAN UNION EURO"]
        case 3:
            return ["JPY", "¥", "JAPANESE YEN"]
        case 4:
            return ["GBP", "£", "GREAT BRITAIN POUND"]
        case 5:
            return ["AUD", "₳", "AUSTRALIAN DOLLARS"]
        case 6:
            return ["CAD", "$", "CANADIAN DOLLARS"]
        default:
            return ["USD", "$", "UNITED STATES DOLLARS"]
        }
    }
    
    func flagSwitcher(tag: Int) -> String {
        switch tag {
        case 0:
            return "🇺🇸"
        case 1:
            return "🇮🇳"
        case 2:
            return "🇪🇺"
        case 3:
            return "🇯🇵"
        case 4:
            return "🇬🇧"
        case 5:
            return "🇦🇺"
        case 6:
            return "🇨🇦"
        default:
            return "🇮🇳"
        }
        
    }
}
