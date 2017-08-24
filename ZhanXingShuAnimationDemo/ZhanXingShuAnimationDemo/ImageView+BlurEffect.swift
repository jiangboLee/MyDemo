//
//  ImageView+BlurEffect.swift
//  ZhanXingShuAnimationDemo
//
//  Created by ljb48229 on 2017/8/18.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

extension UIImageView {

    func addBlurEffect() -> UIVisualEffectView {
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.frame
        self.addSubview(blurEffectView)
        return blurEffectView
    }
    
    func addRoundBlurEffect(width blurWidth: CGFloat) -> UIVisualEffectView {
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRect(x: 0.5 * (frame.width - blurWidth), y: 0.5 * (frame.height - blurWidth), width: blurWidth, height: blurWidth)
        blurEffectView.layer.cornerRadius = 0.5 * blurWidth;
        blurEffectView.clipsToBounds = true
        self.addSubview(blurEffectView)
        return blurEffectView
    }
}

