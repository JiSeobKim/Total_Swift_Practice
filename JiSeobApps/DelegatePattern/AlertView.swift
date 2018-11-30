//
//  AlertView.swift
//  JiSeobApps
//
//  Created by kimjiseob on 30/11/2018.
//  Copyright © 2018 kimjiseob. All rights reserved.
//

import Foundation
import UIKit

protocol AlertViewDelegate {
    func okTapAction() -> UIAlertAction?
    func cancelTapAction() -> UIAlertAction?
    func completionAction()
    
    var alertTitle:String? {get}
    
    var message:String? {get}
    
}

class AlertView: UIView {
    
    var alertDelegate: AlertViewDelegate?
    
    var button: UIButton!
    
    private var vc: UIViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    convenience init(frame: CGRect, vc: UIViewController) {
        self.init(frame: frame)
        self.vc = vc
    }
    
    
    func config() {
        
        button = UIButton()
        button.frame.size = CGSize(width: 40, height: 25)
        button.center = self.center
        button.setTitle("Alert!", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        self.addSubview(button)
        
        
        self.backgroundColor = .blue
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    @objc func showAlert() {
        
        let alert = UIAlertController(title: alertDelegate?.alertTitle, message: alertDelegate?.message, preferredStyle: .alert)
        
        if let okAction = alertDelegate?.okTapAction() {
            alert.addAction(okAction)
        }
        
        if let cancelAction = alertDelegate?.cancelTapAction() {
            alert.addAction(cancelAction)
        }
        
        vc.present(alert, animated: true) {
            self.alertDelegate?.completionAction()
        }
    }
    
    
    
}
