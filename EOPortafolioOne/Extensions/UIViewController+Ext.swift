//
//  UIViewController+Ext.swift
//  EOPortafolioOne
//
//  Created by Esteban Ordonez on 5/1/20.
//  Copyright © 2020 Esteban Ordonez. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupToolBar(on textField: BoltTextField){
        let toolBar             = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        let flexSpace           = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton          = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneActionButton))
        
        doneButton.tintColor    = .systemIndigo
        
        toolBar.setItems([flexSpace, doneButton], animated: false)
        toolBar.sizeToFit()
        
        textField.inputAccessoryView = toolBar
        
    }
    
    
    @objc func doneActionButton(){
        self.view.endEditing(true)
    }
    
    
    func presentBoltAlertOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC                    = BoltAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle   = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
