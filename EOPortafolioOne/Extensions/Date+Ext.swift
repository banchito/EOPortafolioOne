//
//  Date+Ext.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/13/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import Foundation
extension Date {
    func convertToMonthYearFormat() -> String{
        let dateFormater            = DateFormatter()
        dateFormater.dateFormat     = "HH:mm"
        dateFormater.locale         = Locale(identifier: "en_US_POSIX")
        dateFormater.timeZone       = .current
        
        
        return dateFormater.string(from: self)
    }
}


