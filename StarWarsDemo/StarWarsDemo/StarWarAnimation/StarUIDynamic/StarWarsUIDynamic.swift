//
//  StarWarsUIDynamic.swift
//  StarWarsDemo
//
//  Created by 李江波 on 2017/8/26.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

class StarWarsUIDynamic: NSObject, UIViewControllerAnimatedTransitioning {

    open var duration: TimeInterval = 2
    open var spriteWidth: CGFloat = 10
    
    var trainsitionContext: UIViewControllerContextTransitioning!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    var animator: UIDynamicAnimator!
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!.view
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!.view
        
        containerView.addSubview(toView!)
        containerView.sendSubview(toBack: toView!)
        
        let size = fromView?.frame.size
        
        func randomFloatBetween(_ smallNumber: CGFloat, and bigNumber: CGFloat) -> CGFloat {
            
            let diff = bigNumber - smallNumber
            //truncatingRemainder 取余
            return (CGFloat(arc4random()) / 100).truncatingRemainder(dividingBy: diff) + smallNumber
        }
        
        let fromViewSnapshot = fromView?.snapshotView(afterScreenUpdates: false)
        let width = spriteWidth
        let height = width
        
        animator = UIDynamicAnimator(referenceView: containerView)
        
        var snapshots: [UIView] = []
        for x in stride(from: CGFloat(0), through: (size?.width)!, by: width) {
            for y in stride(from: CGFloat(0), through: (size?.height)!, by: height) {
                
                let snapshotRegion = CGRect(x: x, y: y, width: width, height: height)
                //resizableSnapshotView 学到新方法
                let snapshot = fromViewSnapshot!.resizableSnapshotView(from: snapshotRegion, afterScreenUpdates: false, withCapInsets: UIEdgeInsets.zero)!
                
                containerView.addSubview(snapshot)
                snapshot.frame = snapshotRegion
                snapshots.append(snapshot)
                
                let push = UIPushBehavior(items: [snapshot], mode: .instantaneous)
                push.pushDirection = CGVector(dx: randomFloatBetween(-0.15, and: 0.15), dy: randomFloatBetween(-0.15, and: 0))
                push.active = true
                animator.addBehavior(push)
            }
        }
        let gravity = UIGravityBehavior(items: snapshots)
        animator.addBehavior(gravity)
        
        fromView?.removeFromSuperview()
        
        Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(completeTrasition), userInfo: nil, repeats: false)
        self.trainsitionContext = transitionContext
    }
    
    func completeTrasition() {
        trainsitionContext.completeTransition(!trainsitionContext.transitionWasCancelled)
    }
}
