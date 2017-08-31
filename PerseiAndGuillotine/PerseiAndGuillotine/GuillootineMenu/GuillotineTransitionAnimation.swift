//
//  GuillotineTransitionAnimation.swift
//  PerseiAndGuillotine
//
//  Created by ljb48229 on 2017/8/31.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

public protocol GuillotineMenu {

    var dismissButton: UIButton? {get}
    var titleLable: UILabel? {get}
}

public protocol GuillotineAnimationDelegate: class {
    
    func animatorDidFinishPresentation(_ animator: GuillotineTransitionAnimation)
    func animatorDidFinishDismissal(_ animator: GuillotineTransitionAnimation)
    func animatorWillStartPresentation(_ animator: GuillotineTransitionAnimation)
    func animatorWillStartDismissal(_ animator: GuillotineTransitionAnimation)
}

//extension GuillotineAnimationDelegate {
//
//    func animatorDidFinishPresentation(_ animator: GuillotineTransitionAnimation) {}
//    func animatorDidFinishDismissal(_ animator: GuillotineTransitionAnimation) {}
//    func animatorWillStartPresentation(_ animator: GuillotineTransitionAnimation) {}
//    func animatorWillStartDismissal(_ animator: GuillotineTransitionAnimation) {}
//}


open class GuillotineTransitionAnimation: NSObject {

    public enum Mode {
        case presentation
        case dismissal
    }
    open weak var animationDelegate: GuillotineAnimationDelegate?
    open var mode: Mode = .presentation
    open var supportView: UIView?
    open var presentButton: UIView?
    open var animationDuration = 0.1
    
    fileprivate var containerMenuButton: UIButton? {
        didSet {
//           presentButton?.addObserver(self, forKeyPath: "frame", options: .new, context: myContext)
        }
    }
    
    fileprivate var displayLink: CADisplayLink!
    fileprivate var fromYPresentationLandscapeAdjustment: CGFloat = 1.0
    fileprivate var fromYDismissalLandscapeAdjustment: CGFloat = 1.0
    fileprivate var toYDismissalLandscapeAdjustment: CGFloat = 1.0
    fileprivate var fromYPresentationAdjustment: CGFloat = 1.0
    fileprivate var fromYDismissalAdjustment: CGFloat = 1.0
    fileprivate var toXPresentationLandscapeAdjustment: CGFloat = 1.0
    fileprivate let initialMenuRotationAngle: CGFloat = -90
    
    fileprivate let myContext: UnsafeMutableRawPointer? = nil
    fileprivate var menu: UIViewController!
    fileprivate var topOffset: CGFloat = 0
    fileprivate var animationContext: UIViewControllerContextTransitioning!
    fileprivate var vectorDY: CGFloat = 1500
    fileprivate let vectorDYCoefficient: Double = 2 / Double.pi
    
    //MARK: - Init
    override init() {
        super.init()
        
        setupDisplayLink()
        setupSystemVersionAdjustment()
    }
    
    fileprivate func setupDisplayLink() {
        displayLink = {
            
            let displayLink = CADisplayLink(target: self, selector: #selector(updateContainerMenuButton))
            displayLink.add(to: .current, forMode: .commonModes)
            displayLink.isPaused = true
            return displayLink
        }()
    }
    
    @objc fileprivate func updateContainerMenuButton() {
        
    }
    //MARK: - 版本判断
    fileprivate func setupSystemVersionAdjustment() {
        let device = UIDevice.current
        let iosVersion = Double(device.systemVersion) ?? 0
        let iOS9 = iosVersion >= 9
        
        if iOS9 {
            fromYPresentationLandscapeAdjustment = 1.5
            fromYDismissalLandscapeAdjustment = 1.0
            fromYPresentationAdjustment = -1.0
            fromYDismissalAdjustment = -1.0
            toXPresentationLandscapeAdjustment = 1.0
            toYDismissalLandscapeAdjustment = -1.0
        } else {
            fromYPresentationLandscapeAdjustment = 0.5
            fromYDismissalLandscapeAdjustment = 0.0
            fromYPresentationAdjustment = -1.5
            fromYDismissalAdjustment = 1.0
            toXPresentationLandscapeAdjustment = -1.0
            toYDismissalLandscapeAdjustment = 1.5
        }
    }

    func setupContainerMenuButtonFrameAndTopOffset() {
        topOffset = supportView!.frame.origin.y + supportView!.bounds.height
        let senderRect = supportView!.convert(presentButton!.frame, to: nil)
        containerMenuButton?.frame = senderRect
    }
    
    //MARK: - Observer
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == myContext {
            setupContainerMenuButtonFrameAndTopOffset()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

}

extension GuillotineTransitionAnimation: UIViewControllerAnimatedTransitioning {

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        switch mode {
        case .presentation:
            animationPresentation(using: transitionContext)
        case .dismissal:
            animationDismissal(using: transitionContext)
        }
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
}

fileprivate extension GuillotineTransitionAnimation {

    fileprivate func animationPresentation(using context: UIViewControllerContextTransitioning) {
        
        menu = context.viewController(forKey: UITransitionContextViewControllerKey.to)
        context.containerView.addSubview(menu.view)
        
        if menu is GuillotineMenu {
            if supportView != nil && presentButton != nil {
                let guillotineMenu = menu as! GuillotineMenu
                containerMenuButton = guillotineMenu.dismissButton
                setupContainerMenuButtonFrameAndTopOffset()
                context.containerView.addSubview(containerMenuButton!)
            }
        }
        let fromVC = context.viewController(forKey: UITransitionContextViewControllerKey.from)
        fromVC?.beginAppearanceTransition(false, animated: true)
        
        animationDelegate?.animatorWillStartPresentation(self)
        
        animateMenu(menu.view, context: context)
    }
    
    fileprivate func animateMenu(_ view: UIView, context:UIViewControllerContextTransitioning) {
    
        animationContext = context
        vectorDY = CGFloat(vectorDYCoefficient * Double(UIScreen.main.bounds.height) / animationDuration)
        
        var rotationDirection = CGVector(dx: 0, dy: -vectorDY)
        var fromX: CGFloat
        
        
        
    }
    
    fileprivate func animationDismissal(using context: UIViewControllerContextTransitioning) {
        
    }
}





