//
//  BoltMin&MaxVC.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/13/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import UIKit

class BoltMinMaxVC: BoltItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    
    private func configureItem(){
        itemInfoViewOne.set(itemInfoType    : .max,     withInfo    : weather.maxString)
        itemInfoViewTwo.set(itemInfoType    : .min,     withInfo    : weather.minString)
        itemInfoViewThree.set(itemInfoType  : .sunrise, withInfo    : weather.sunrise.convertToMonthYearFormat())
        itemInfoViewFour.set(itemInfoType   : .sunset,  withInfo    : weather.sunset.convertToMonthYearFormat())
    }
}
