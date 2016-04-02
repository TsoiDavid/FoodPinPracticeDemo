//
//  ShareViewController.swift
//  FoodPin
//
//  Created by TsoiKaShing on 16/4/2.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    @IBOutlet weak var facebook: UIButton!
    
    @IBOutlet weak var message: UIButton!
    
    @IBOutlet weak var twitter: UIButton!
    
    @IBOutlet weak var email: UIButton!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        //按钮初始状态属性设置
        facebook.alpha = 0
        message.alpha = 0
        twitter.alpha = 0
        email.alpha = 0
        
        facebook.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height)
        message.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height)
        twitter.transform = CGAffineTransformMakeTranslation(0, -self.view.frame.size.height)
        email.transform = CGAffineTransformMakeTranslation(0, -self.view.frame.size.height)
        

    }
    override func viewDidAppear(animated: Bool) {
        //按钮动画
        buttonAnimation()
    }
    
    func buttonAnimation() {
        
        UIView.animateWithDuration(0.4,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0.3,
                options: .LayoutSubviews,
                animations: { () -> Void in
                    
                self.facebook.alpha = 1
                self.facebook.transform = CGAffineTransformMakeTranslation(0, -30)
                    
                }) { (Bool) -> Void in
            
                    UIView.animateWithDuration(0.4,
                        delay: 0,
                        usingSpringWithDamping: 0.8,
                        initialSpringVelocity: 0.1,
                        options: .LayoutSubviews,
                        animations: { () -> Void in
                            
                        self.message.alpha = 1
                        self.message.transform = CGAffineTransformMakeTranslation(0, -30)
                            
                    }, completion: { (Bool) -> Void in
                                
                        UIView.animateWithDuration(0.7, delay: 0.0,
                            usingSpringWithDamping: 0.6,
                            initialSpringVelocity: 0.1,
                            options:.LayoutSubviews,
                            animations: {
                            self.facebook.transform = CGAffineTransformMakeTranslation(0,0)
                            self.message.transform = CGAffineTransformMakeTranslation(0,0)
                            }, completion: nil)
                    })
        }
        
        
        UIView.animateWithDuration(0.4,
                                delay: 0,
                                usingSpringWithDamping: 1,
                                initialSpringVelocity: 0.3,
                                options: .LayoutSubviews,
                                animations: { () -> Void in
                                self.twitter.alpha = 1
                                self.twitter.transform = CGAffineTransformMakeTranslation(0, 30)
            
                            }) { (Bool) -> Void in
                                    
                                    UIView.animateWithDuration(0.4,
                                    delay: 0.0,
                                    usingSpringWithDamping: 0.8,
                                    initialSpringVelocity: 0.1,
                                    options:.LayoutSubviews,
                                    animations: {
                                        
                                    self.email.alpha = 1
                                    self.email.transform = CGAffineTransformMakeTranslation(0, 30)
                                        
                                    }, completion: { (Bool) -> Void in
                                        
                                        UIView.animateWithDuration(0.7,
                                            delay: 0.0,
                                            usingSpringWithDamping: 0.6,
                                            initialSpringVelocity: 0.1,
                                            options:.LayoutSubviews,
                                            animations: {
                                                self.twitter.transform = CGAffineTransformMakeTranslation(0, 0)
                                                self.email.transform = CGAffineTransformMakeTranslation(0,0)
                                                        }, completion: nil)
                                        })

                                }


        }

    }
