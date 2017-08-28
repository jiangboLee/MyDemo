//
//  ZoomStartupAnimation.swift
//  FitTrackSwift3
//
//  Created by ljb48229 on 2017/8/28.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

private let startAnimationImageWidth: CGFloat = 172.0
private let finishAnimationImageWidth: CGFloat = 2000.0

private let transfromAnimationDuration: TimeInterval = 3.0
private let transfromAnimationDelay: TimeInterval = 1
private let maskBackgroundImageViewAnimationDuration: TimeInterval = 0.3
private let maskBackgroundImageViewAnimationDelay: TimeInterval = 2.0

class ZoomStartupAnimation {

    static func performAnimation(_ window: UIWindow, navControllerIdentifier: String, backgroundImage: UIImage, animationImage: UIImage) {
        
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = backgroundImage
        
        window.addSubview(backgroundImageView)
        window.makeKeyAndVisible()
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navController = mainStoryboard.instantiateViewController(withIdentifier: navControllerIdentifier) as! UINavigationController
        window.rootViewController = navController
        
        navController.view.layer.mask = CALayer()
        navController.view.layer.mask?.contents = animationImage.cgImage
        navController.view.layer.mask?.bounds = CGRect(x: 0, y: 0, width: startAnimationImageWidth, height: startAnimationImageWidth)
        navController.view.layer.mask?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        navController.view.layer.mask?.position = CGPoint(x: navController.view.frame.width / 2, y: navController.view.frame.height / 2)
        
        let maskBackgroundImageView = UIImageView(frame: navController.view.layer.mask!.frame)
        maskBackgroundImageView.image = animationImage
        navController.view.addSubview(maskBackgroundImageView)
        navController.view.bringSubview(toFront: maskBackgroundImageView)
        
        createTransfromAnimation(navController, maskBackgroundImageView: maskBackgroundImageView)
        maskBackGroundImageViewAnimation(maskBackgroundImageView, navController: navController)
    }
    
    fileprivate static func createTransfromAnimation(_ navController: UINavigationController, maskBackgroundImageView: UIImageView) {
        
        let transfromAnimation = CAKeyframeAnimation(keyPath: "bounds")
        transfromAnimation.duration = transfromAnimationDuration
        transfromAnimation.beginTime = CACurrentMediaTime() + transfromAnimationDelay
        let initalBounds = NSValue(cgRect: navController.view.layer.mask!.bounds)
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: finishAnimationImageWidth, height: finishAnimationImageWidth))
        transfromAnimation.values = [initalBounds, finalBounds]
        transfromAnimation.timingFunctions = [CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)]
        transfromAnimation.isRemovedOnCompletion = false
        transfromAnimation.fillMode = kCAFillModeForwards
        navController.view.layer.mask!.add(transfromAnimation, forKey: "maskAnimation")
        maskBackgroundImageView.layer.add(transfromAnimation, forKey: "maskAnimation")
    }
    
    fileprivate static func maskBackGroundImageViewAnimation(_ maskBackgroundImageView: UIImageView, navController: UINavigationController) {
    
        UIView.animate(withDuration: maskBackgroundImageViewAnimationDuration, delay: maskBackgroundImageViewAnimationDelay, options: .curveEaseIn, animations: { 
            maskBackgroundImageView.alpha = 0
        }) { (_) in
            
            maskBackgroundImageView.removeFromSuperview()
            navController.view.layer.mask = nil
        }
    }
}






