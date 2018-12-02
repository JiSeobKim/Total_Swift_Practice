//
//  RxCalModel.swift
//  JiSeobApps
//
//  Created by kimjiseob on 02/12/2018.
//  Copyright © 2018 kimjiseob. All rights reserved.
//

import Foundation

enum OperatorList: String {
    case add = "+"
    case sub = "-"
    case mul = "X"
    case div = "/"
    case dot = "."
    case end = "="
}

enum SpecialList: String {
    case save = "Save"
    case errorClear = "CE"
    case allClear = "AC"
}

class RxCalModel {
    
    var nowNumber = 0
    var dotCount = 0
    var numberLog: [Int] = []
    
    
    // 숫자 입력
    func inputNumber(num:Int) {
        
    }
    // 사칙 연산 입력
    func inputOperator(){
        
    }
    // 특수 기능 입력
    func inputSpecial() {
        
    }
    
    
    
}
