//
//  RxCalculatorVC.swift
//  JiSeobApps
//
//  Created by kimjiseob on 30/11/2018.
//  Copyright © 2018 kimjiseob. All rights reserved.
//

import UIKit

class RxCalculatorVC: UIViewController {
    @IBOutlet weak var lbInput: UILabel!
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var lbLog: UILabel!
    
    var logArray: [String] = [] {
        didSet {
            var text = ""
            for row in logArray {
                text += "\(row) "
            }
            
            self.lbLog.text = text
        }
    }
    var result: Double = 0 {
        didSet {
            print("result = \(result)")
            lbResult.text = result.description
        }
    }
    var typing: Double = 0 {
        didSet {
            print("result = \(typing)")
            lbInput.text = typing.description
        }
    }
    
    var oldOperator: String?
    var lastInputIsOperator = false
    enum Oper: String {
        case add = "+"
        case sub = "-"
        case mul = "X"
        case div = "/"
        case end = "="
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func operatorNumber(input: String) {
        self.logArray.append("\(typing.description) \(input) ")
        let oldTemp = self.oldOperator ?? "+"
        self.oldOperator = input
        
        
        
        let tempTyping = typing
        self.typing = 0
        
        let oper = Oper.init(rawValue: oldTemp)!
        
        
        switch oper {
        case .add:
            result += tempTyping
        case .sub:
            result -= tempTyping
        case .mul:
            result *= tempTyping
        case .div:
            guard typing != 0 else {
                result = 0
                return
            }
            result /= tempTyping
        case .end:
            typing = 0
            let temp = result
            result = temp
        }
        
        self.lbInput.text = input
    }
    
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        let text = sender.currentTitle ?? ""
        
        
        if let num = Double(text) {
            typing = (typing * 10) + num
        } else {
            
            operatorNumber(input: text)
        }
        
        
        
        
    }
}
