//
//  BoltBodyLabel.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/4/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import UIKit

class BoltBodyLabel: UILabel {


  override init(frame: CGRect) {
      super.init(frame: frame)
      configure()
  }
  
  init(textAlignment: NSTextAlignment) {
      super.init(frame: .zero)
      self.textAlignment = textAlignment
      configure()
  }
  
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  
  private func configure() {
      textColor                 = .secondaryLabel
    font                      = UIFont.preferredFont(forTextStyle: .body)
      adjustsFontSizeToFitWidth = true
      minimumScaleFactor        = 0.7
      lineBreakMode             = .byWordWrapping
      translatesAutoresizingMaskIntoConstraints   = false
  }

}
