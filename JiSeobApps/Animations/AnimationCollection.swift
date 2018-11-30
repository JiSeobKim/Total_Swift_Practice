//
//  AnimationCollection.swift
//  JiSeobApps
//
//  Created by kimjiseob on 19/11/2018.
//  Copyright © 2018 kimjiseob. All rights reserved.
//

import Foundation
import UIKit



class RepeatVerticalMove: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var objectList: [UIView] = []
    var speed:CGFloat = 1
    var randomColor : [UIColor] = [.red, .blue, .green, .yellow]
    
    
    private var cellSize: CGFloat?
    private var cnt: Int?
    private var objectSize: CGFloat!
    
    
    convenience init(size: CGFloat, color: UIColor, cnt: Int, padding: CGFloat = 0) {
        
        self.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        
        self.cellSize = size
        self.cnt = cnt
        
        
        for row in (0...cnt - 1) {
            let view = makeCircle(color: color, size: size, cnt: cnt, padding: padding)
            
            let positionX: CGFloat!
            
//            if row != 0 {
//                positionX = ((size / CGFloat(cnt)) * CGFloat(row)) + padding
//            } else {
//                positionX = ((size / CGFloat(cnt)) * CGFloat(row))
//            }
            positionX = (((size + padding) / CGFloat(cnt)) * CGFloat(row))
            
            let positionY: CGFloat = (self.cellSize! - (cellSize! / CGFloat(cnt))) / 2
            
            view.frame.origin = CGPoint(x: positionX, y: positionY)
            
            UIView.animate(withDuration: 0.5) {
                view.alpha = 1
            }
            
            
            self.objectList.append(view)
            self.addSubview(view)
        }
    }
    
    
    
    
    
    
    func makeCircle(color : UIColor, size : CGFloat, cnt: Int, padding: CGFloat = 0) -> UIView {
        
        
        
        let totalPadding = padding * CGFloat(cnt - 1)
        
        objectSize = (size - totalPadding) / CGFloat(cnt)
        
        
        let returnView = UIView(frame: CGRect(x: 0, y: 0, width: objectSize, height: objectSize))
        
        returnView.alpha = 0
        returnView.layer.cornerRadius = CGFloat(objectSize) / 2
        
        returnView.backgroundColor = color
        return returnView
    }
    
    
    func startAnimation() {
        
        
        for row in objectList {
            
            
            let random = CGFloat.random(in: 0...1)
            let randomD = CGFloat.random(in: 0.5...1)
            
            UIView.animateKeyframes(withDuration: TimeInterval(speed * randomD), delay: TimeInterval(speed *  random), options: [.repeat, .autoreverse], animations: {
                row.frame = CGRect(x: row.frame.origin.x, y: 0, width: row.frame.width, height: self.cellSize!)
                
//                row.alpha = 0.5
            }, completion: nil)
        }
        
    }
    
    func stopAnimation() {
        for row in objectList {
            
            
            row.layer.removeAllAnimations()
//            row.layer.ani
            UIView.animateKeyframes(withDuration: TimeInterval(speed), delay: 0, options: [], animations: {
//                row.frame.size.height = self.cellSize! / CGFloat(self.cnt!)
                row.frame.size.height = 0
                
                row.alpha = 1
                
            }, completion: nil)
        }
        
    }
    
    
    func activeRandomColor() {
        
        
//        for row in objectList {
//            if tempColor.count == 0 {
//                tempColor = self.randomColor
//            }
//            let random = Int.random(in: 0...tempColor.count-1)
//            row.backgroundColor = randomColor[random]
//            tempColor.remove(at: random)
//        }
        
        
        for (c,row) in objectList.enumerated() {
            let number = c % randomColor.count
            row.backgroundColor = randomColor[number]
        }
    }
    
    func endingAnimation() {
        
        
        
        for (c,row) in objectList.enumerated() {
            UIView.animate(withDuration: 0.3, animations: {
                    row.frame = CGRect(x: row.frame.origin.x, y: self.cellSize! / 2, width: self.objectSize, height: 0)
                }, completion: { (bool) in
                    row.layer.removeAllAnimations()
                    row.layer.cornerRadius = self.objectSize / 2
                    UIView.animate(withDuration: 0.5, animations: {
                        row.frame.size.height = self.objectSize
                        
                    }, completion: { (bool) in
                        UIView.animate(withDuration: 1, delay: TimeInterval(0.1 * Double(c)), options: [], animations: {
                            
                            row.frame = CGRect(x: self.cellSize! / 2, y: -self.objectSize, width: self.objectSize, height: self.objectSize)
                        }) { (bool) in
                            let factor = Float(c) * 1 / 5
                            let animation = self.rotateAnimation(factor, x: row.frame.width * 3.3, y: row.frame.height * 3, size: CGSize(width: self.cellSize!, height: self.cellSize!))
                            row.layer.add(animation, forKey: "animation")
                        }
                    })
                    
                    //
                    
                    
                    
                })
        }
    }
    
    
    
    
    
    func rotateAnimation(_ rate: Float, x: CGFloat, y: CGFloat, size: CGSize) -> CAAnimationGroup {
        let duration: CFTimeInterval = 1.5
        let fromScale = 1 - rate
        let toScale = 0.2 + rate
        let timeFunc = CAMediaTimingFunction(controlPoints: 0.5, 0.15 + rate, 0.25, 1)
        
        
        // Scale animation
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = duration
        scaleAnimation.repeatCount = HUGE
        scaleAnimation.fromValue = fromScale
        scaleAnimation.toValue = toScale
        
        // Position animation
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.duration = duration
        positionAnimation.repeatCount = HUGE
        positionAnimation.path = UIBezierPath(arcCenter: CGPoint(x: x, y: y), radius: size.width / 2, startAngle: CGFloat(3 * Double.pi * 0.5), endAngle: CGFloat(3 * Double.pi * 0.5 + 2 * Double.pi), clockwise: true).cgPath
        
        // Aniamtion
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation, positionAnimation]
        animation.timingFunction = timeFunc
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        
        return animation
    }
    
    
}
