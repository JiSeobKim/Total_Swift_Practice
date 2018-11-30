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

}

extension AlertViewDelegate {
    func cancelTapAction() -> UIAlertAction? {
        let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
        return cancel
    }
    func completionAction() {
        
    }
}

class AlertView: UIView {
    
    var alertDelegate: AlertViewDelegate?
    
    var button: UIButton!
    var titleStr: String!
    var messageStr: String!
    
    private var vc: UIViewController!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    convenience init(frame: CGRect, vc: UIViewController, title: String?, message: String?) {
        self.init(frame: frame)
        self.vc = vc
        self.titleStr = title
        self.messageStr = message
    }
    
    
    func config() {
        
        button = UIButton()
        button.frame.size = self.frame.size
        button.center = self.center
        button.setTitle("Alert!", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        self.addSubview(button)
        
        
        self.backgroundColor = .blue
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    
    @objc func showAlert() {
        
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
        
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
