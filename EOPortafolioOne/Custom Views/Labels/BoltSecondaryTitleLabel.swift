//
//  BoltSecondaryTitleLabel.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/8/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import UIKit

class BoltSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        textColor                 = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.7
        lineBreakMode             = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints   = false
    }

}
