//
//  DelegateVC.swift
//  JiSeobApps
//
//  Created by kimjiseob on 30/11/2018.
//  Copyright © 2018 kimjiseob. All rights reserved.
//

import UIKit

class DelegateVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        

    }
    
    
    
    func initLayout() {
        
        
        let view = AlertView(frame: CGRect(x: 0, y: 0, width: 150, height: 50), vc: self)
        view.center = self.view.center
        view.alertDelegate = self
        
        self.view.addSubview(view)
    }
    

}

extension DelegateVC: AlertViewDelegate {
    
    func completionAction() {
        
    }
    

    
    var alertTitle: String? {
        return "T..Title?"
    }
    
    
    
    var message: String? {
        return "M...Message"
    }
    
    
    func okTapAction() -> UIAlertAction? {
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            print(action.title)
        }
        
        return action
    }
    
    func cancelTapAction() -> UIAlertAction? {
        let action = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        return action
    }
    

    
    
}
