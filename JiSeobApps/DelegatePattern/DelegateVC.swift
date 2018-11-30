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
        let view = AlertView(frame: CGRect(x: 0, y: 0, width: 150, height: 50), vc: self, title: "T..Title!!", message: "M..Message!")
        view.center = self.view.center
        view.alertDelegate = self
        self.view.addSubview(view)
    }
}

extension DelegateVC: AlertViewDelegate {
    
    func okTapAction() -> UIAlertAction? {
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            print(action.title!)
        }
        return action
    }
}
