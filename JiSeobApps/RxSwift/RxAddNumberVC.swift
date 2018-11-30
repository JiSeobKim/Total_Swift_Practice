//
//  RxAddNumberVC.swift
//  JiSeobApps
//
//  Created by kimjiseob on 30/11/2018.
//  Copyright © 2018 kimjiseob. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxAddNumberVC: UIViewController {
    
    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!
    @IBOutlet weak var tf3: UITextField!
    @IBOutlet weak var lbResult: UILabel!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.combineLatest(tf1.rx.text.orEmpty, tf2.rx.text.orEmpty, tf3.rx.text.orEmpty) { (tx1,tx2,tx3) -> String in
            
            let no1 = Int(tx1) ?? 0
            let no2 = Int(tx2) ?? 0
            let no3 = Int(tx3) ?? 0
            
            return String(no1 + no2 + no3)
            }.bind(to: self.lbResult.rx.text).disposed(by: disposeBag)
    }

}



/*
 //
 //  RxAddNumberVC.swift
 //  JiSeobApps
 //
 //  Created by kimjiseob on 30/11/2018.
 //  Copyright © 2018 kimjiseob. All rights reserved.
 //
 
 import UIKit
 import RxSwift
 import RxCocoa
 
 class RxAddNumberVC: UIViewController {
 
 @IBOutlet weak var tf1: UITextField!
 @IBOutlet weak var tf2: UITextField!
 @IBOutlet weak var tf3: UITextField!
 @IBOutlet weak var lbResult: UILabel!
 
 let disposeBag = DisposeBag()
 
 
 override func viewDidLoad() {
 super.viewDidLoad()
 //        tf1.addTarget(self, action: #selector(cal), for: .editingChanged)
 //        tf2.addTarget(self, action: #selector(cal), for: .editingChanged)
 //        tf3.addTarget(self, action: #selector(cal), for: .editingChanged)
 
 cal()
 
 Observable.combineLatest(tf1.rx.text.orEmpty, tf2.rx.text.orEmpty, tf3.rx.text.orEmpty) { (tx1,tx2,tx3) -> String in
 
 let no1 = Int(tx1) ?? 0
 let no2 = Int(tx2) ?? 0
 let no3 = Int(tx3) ?? 0
 
 return String(no1 + no2 + no3)
 }.bind(to: self.lbResult.rx.text).disposed(by: disposeBag)
 }
 
 @objc func cal() {
 let num1 = Int(tf1.text ?? "0") ?? 0
 let num2 = Int(tf2.text ?? "0") ?? 0
 let num3 = Int(tf3.text ?? "0") ?? 0
 
 self.lbResult.text = String(num1 + num2 + num3)
 }
 
 }

 */
