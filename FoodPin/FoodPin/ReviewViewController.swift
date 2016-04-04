//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by TsoiKaShing on 16/4/2.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //iOS8 ->设置毛玻璃效果 
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffevtView = UIVisualEffectView(effect: blurEffect)
        blurEffevtView.frame = self.view.bounds
        backgroundImageView.addSubview(blurEffevtView)
        //动画
        dialogView.transform = CGAffineTransformMakeTranslation(0,self.view.frame.size.height)

        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        dialogViewAnitmation()
    }
    func dialogViewAnitmation() {
        //usingSpringWithDamping 的范围为 0.0f 到 1.0f ，数值越小「弹簧」的振动效果越明显。
        //initialSpringVelocity 则表示初始的速度，数值越大一开始移动越快。
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.1, options: UIViewAnimationOptions.LayoutSubviews, animations: {
            self.dialogView.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
  
    }
}



