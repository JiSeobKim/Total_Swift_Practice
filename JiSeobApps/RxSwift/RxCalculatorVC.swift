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
    var isReplaceOperator = false
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func operatorNumber(input: String) {
        let oldTemp = self.oldOperator ?? "+"
        self.oldOperator = input
        
        
        guard isReplaceOperator == false else {
            self.logArray.removeLast()
            self.logArray.append(input)
            return
        }
        
        
        self.logArray.append(contentsOf: [typing.description, input])
        
        let tempTyping = typing
        
        
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
        
        self.typing = 0
        self.lbInput.text = input
        self.isReplaceOperator = true
    }
    
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        let text = sender.currentTitle ?? ""
        
        if let num = Double(text) {
            self.isReplaceOperator = false
            typing = (typing * 10) + num
        } else {
            operatorNumber(input: text)
        }
    }
}
