//
//  StarGLAnimator.swift
//  StarWarsDemo
//
//  Created by 李江波 on 2017/8/27.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit
import GLKit
//  Latest version can be found at https://github.com/Yalantis/StarWars.iOS
class StarGLAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var duration: TimeInterval = 2
    var spriteWidth: CGFloat = 8
    
    fileprivate var glContext: EAGLContext!
    fileprivate var glView: GLKView!
    fileprivate var effect: GLKBaseEffect!
//    fileprivate var render:
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!.view
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!.view
        
        containerView.addSubview(toView!)
        //放在最下面
        containerView.sendSubview(toBack: toView!)
        
        func randomFloatBetween(_ smallNumber: CGFloat, and bigNumber: CGFloat) -> CGFloat {
            let diff = bigNumber - smallNumber
            return (CGFloat(arc4random()) / 100).truncatingRemainder(dividingBy: diff) + smallNumber
        }
        
        self.glContext = EAGLContext(api: .openGLES2)
        EAGLContext.setCurrent(glContext)
        
        glView = GLKView(frame: (fromView?.frame)!, context: glContext)
        glView.enableSetNeedsDisplay = true
        glView.delegate = self
        glView.isOpaque = false
        containerView.addSubview(glView)
        
        let texture = ViewTexture()
        texture.setupOpenGL()
        texture.render(view: fromView!)
        
        effect = GLKBaseEffect()
        let projectionMatrix = GLKMatrix4MakeOrtho(0, Float(texture.width), 0, Float(texture.height), -1, 1)
        effect.transform.projectionMatrix = projectionMatrix
        
        
        
    }
}

extension StarGLAnimator: GLKViewDelegate {

    func glkView(_ view: GLKView, drawIn rect: CGRect) {
        
    }
}
