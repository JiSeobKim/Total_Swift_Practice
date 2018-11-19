//
//  AnimationsVC.swift
//  JiSeobApps
//
//  Created by kimjiseob on 19/11/2018.
//  Copyright © 2018 kimjiseob. All rights reserved.
//

import UIKit

class AnimationsVC: UIViewController {

    @IBOutlet weak var stepPadding: UIStepper!
    @IBOutlet weak var stepCount: UIStepper!
    @IBOutlet weak var stepSize: UIStepper!
    
    
    @IBOutlet weak var lbPaddingValue: UILabel!
    @IBOutlet weak var lbCountValue: UILabel!
    @IBOutlet weak var lbSizeValue: UILabel!
    
    
    private var padding: CGFloat = 5
    private var cnt = 5
    private var size: CGFloat = 100
    
    private var aniView : RepeatVerticalMove?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stepPadding.value = Double(self.padding)
        self.stepCount.value = Double(self.cnt)
        self.stepSize.value = Double(self.size)

        
        self.lbPaddingValue.text = Int(stepPadding.value).description
        self.lbCountValue.text = Int(stepCount.value).description
        self.lbSizeValue.text = Int(stepSize.value).description
        // Do any additional setup after loading the view.
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        self.getStartAnimationView()
    }
    
    
    @IBAction func startAction(_ sender: Any) {
        getStartAnimationView()
    }
    
    @IBAction func stopAction(_ sender: Any) {
        stopAnimation()
    }
    
    
    func getView() {
        // reset
        if aniView != nil {
            aniView?.removeFromSuperview()
        }
        
        let getView = RepeatVerticalMove(size: size, color: .blue, cnt: self.cnt, padding: self.padding)
        getView.activeRandomColor()
        getView.center = self.view.center
        getView.speed = 0.5
        self.view.addSubview(getView)
        
        aniView = getView
    }
    
    func getStartAnimationView() {
        getView()
        aniView!.startAnimation()
        
    }
    
    
    func getEndAnimation() {
        
        aniView!.endingAnimation()
    }
    
    
    
    
    
    
    func stopAnimation() {
        self.getEndAnimation()
//        UIView.animate(withDuration: 0.5, animations: {
//            self.aniView?.alpha = 0
//
//        }) { (bool) in
//            self.aniView?.removeFromSuperview()
//            self.getEndAnimation()
//        }
    }
    
    
    @IBAction func stepAction(_ sender: UIStepper) {
        
        let value = Int(sender.value)
        
        switch sender {
        case stepPadding:
            self.lbPaddingValue.text = value.description
            self.padding = CGFloat(value)
        case stepCount:
            self.lbCountValue.text = value.description
            self.cnt = value
        case stepSize:
            self.lbSizeValue.text = value.description
            self.size = CGFloat(value)
        default :
            break
        }
        
        
        getStartAnimationView()
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
