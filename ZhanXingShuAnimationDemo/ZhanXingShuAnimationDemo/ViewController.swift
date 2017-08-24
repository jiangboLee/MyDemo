//
//  ViewController.swift
//  ZhanXingShuAnimationDemo
//
//  Created by ljb48229 on 2017/8/18.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private struct AnimationSetting {
    
        let sunDistance: CGFloat = 620
        let moonDistance: CGFloat = 140
        let highlighterDistance: CGFloat = 93
        let particlesVector = CGVector(dx: 400, dy: -100)
        let controlPoint1 = CGPoint(x: 0.47, y: 0.21)
        let controlPoint2 = CGPoint(x: 0.17, y: 0.86)
    }
    private let animationSettings = AnimationSetting()
    
    @IBOutlet private weak var vignetteBackgroundImage: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var moonInLeoView: UIImageView!
    @IBOutlet private weak var sunInAquariusView: UIImageView!
    @IBOutlet private weak var moonLinesView: UIImageView!
    @IBOutlet private weak var sunLinesView: UIImageView!
    @IBOutlet private weak var bottomIcons: UIImageView!
    @IBOutlet private weak var particlesView: UIImageView!
    
    @IBOutlet private weak var outterCircle: UIImageView!
    @IBOutlet private weak var innerCircle: UIImageView!
    @IBOutlet private weak var graphView: UIImageView!
    @IBOutlet private weak var graphPointView: UIImageView!
    
    @IBOutlet private weak var leoView: UIImageView!
    @IBOutlet private weak var aquariusView: UIImageView!
    @IBOutlet private weak var moon: UIImageView!
    @IBOutlet private weak var sun: UIImageView!
    @IBOutlet private weak var highlighterContainer: UIView!
    
    private let iconsHighlighterView = HighlighterView()
    private var moonBlurEffectView: UIVisualEffectView!
    private var toMoon = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
    
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(iconsTapped(tapGestureRecoginzer:)))
        bottomIcons.isUserInteractionEnabled = true
        bottomIcons.addGestureRecognizer(tapGestureRecognizer)
        
        moonBlurEffectView = moon.addRoundBlurEffect(width: 0.45 * moon.bounds.size.width)
        moonBlurEffectView.alpha = 0
        
        iconsHighlighterView.alpha = 0.12
        highlighterContainer.addSubview(iconsHighlighterView)
    }

    func iconsTapped(tapGestureRecoginzer: UITapGestureRecognizer) {
        
        toMoon = !toMoon
        animateMoonMovement()
        animateSunMovement()
        animateGraph()
        animateCircles()
        animateParticles()
        
        animateHighliter()
        animateConstellationText()
    }
    
    private func animateMoonMovement() {
    
        if toMoon {
            self.leoView.alpha = 1
            self.moonLinesView.alpha = 1
        }
        let moonAnimator = UIViewPropertyAnimator(duration: self.toMoon ? 0.5 : 0.56, controlPoint1: animationSettings.controlPoint1, controlPoint2: animationSettings.controlPoint2) { 
            self.moonAnimations()
        }
        moonAnimator.addCompletion { (_) in
            if !self.toMoon {
                self.leoView.alpha = 0
                self.moonLinesView.alpha = 0
            }
        }
        moonAnimator.startAnimation(afterDelay: self.toMoon ? 0.2 : 0)
    }
    
    private func moonAnimations() {
    
        if self.toMoon {
            self.moon.center.x = self.moon.center.x + self.animationSettings.moonDistance
            self.moon.transform = CGAffineTransform.identity
            self.moon.alpha = 1
            
            self.leoView.center.x = self.moon.center.x
            self.leoView.transform = self.moon.transform
            
            self.moonLinesView.center.x = self.moon.center.x
            self.moonLinesView.transform = self.moon.transform
            
            self.moonBlurEffectView.alpha = 0
            
        } else {
            self.moon.center.x = self.moon.center.x - self.animationSettings.moonDistance
            self.moon.transform = CGAffineTransform(scaleX: 0.16, y: 0.16)
            self.moon.alpha = 0.2
            
            self.leoView.center.x = self.moon.center.x
            self.leoView.transform = self.moon.transform
            
            self.moonLinesView.center.x = self.moon.center.x
            self.moonLinesView.transform = self.moon.transform
            
            self.moonBlurEffectView.alpha = 0.5
        }
    }
    
    private func animateSunMovement() {
    
        if !self.toMoon {
            self.sun.isHidden = false
            self.aquariusView.isHidden = false
            self.sunLinesView.isHidden = false
            if self.sun.center.x < self.animationSettings.sunDistance {
                self.sun.center.x = self.sun.center.x + self.animationSettings.sunDistance
                self.aquariusView.center.x = self.sun.center.x
                self.sunLinesView.center.x = self.sun.center.x
                self.sun.transform = CGAffineTransform(scaleX: 7, y: 7)
                self.aquariusView.transform = self.sun.transform
                self.sunLinesView.transform = CGAffineTransform(scaleX: 3.5, y: 3.5)
                self.sun.alpha = 0.1
            }
        }
        let sunAnimator = UIViewPropertyAnimator(duration: self.toMoon ? 0.4 : 0.52, controlPoint1: animationSettings.controlPoint1, controlPoint2: animationSettings.controlPoint2) { 
            self.sunAnimations()
        }
        sunAnimator.addCompletion { (_) in
            if self.toMoon {
                self.sun.isHidden = true
                self.aquariusView.isHidden = true
                self.sunLinesView.isHidden = true
            }
        }
        sunAnimator.startAnimation(afterDelay: self.toMoon ? 0 : 0.18)
    }
    
    private func sunAnimations() {
        if self.toMoon {
            self.sun.center.x = self.sun.center.x + self.animationSettings.sunDistance
            self.sun.transform = CGAffineTransform(scaleX: 6, y: 6)
            self.sun.alpha = 0.1
            
            self.aquariusView.center.x = self.sun.center.x
            self.aquariusView.transform = self.sun.transform
            
            self.sunLinesView.center.x = self.sun.center.x
            self.sunLinesView.transform = CGAffineTransform(scaleX: 3.5, y: 3.5)
            self.sunLinesView.alpha = 0.1
        } else {
            
            self.sun.center.x = self.sun.center.x - self.animationSettings.sunDistance
            self.sun.transform = CGAffineTransform.identity
            self.sun.alpha = 1
            
            self.aquariusView.center.x = self.sun.center.x
            self.aquariusView.transform = self.sun.transform
            self.sunLinesView.center.x = self.sun.center.x
            self.sunLinesView.transform = self.sun.transform
            self.sunLinesView.alpha = 1
        }
    }
    
    /// 曲线动画
    private func animateGraph() {
    
        UIView.animate(withDuration: 0.2, animations: { 
            self.graphView.transform = CGAffineTransform(scaleX: 2.4, y: 0.4)
        }) { (_) in
            self.graphView.center.x = self.graphView.center.x + (self.toMoon ? 1 : -1) * self.animationSettings.moonDistance
            UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveLinear, animations: { 
                self.graphView.alpha = 1
                self.graphPointView.alpha = 1
            }, completion: nil)
        }
        UIView.animate(withDuration: 0.3) { 
            self.graphView.alpha = 0
            self.graphPointView.alpha = 0
        }
        UIView.animate(withDuration: 0.2, delay: 0.6, options: .curveLinear, animations: { 
            self.graphView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    /// 圆形背景
    private func animateCircles() {
    
        func animations(growing: Bool) {
            self.innerCircle.transform = growing ? CGAffineTransform(scaleX: 2, y: 2) : CGAffineTransform.identity
            self.outterCircle.transform = growing ? CGAffineTransform(scaleX: 2, y: 2) : CGAffineTransform.identity
            self.vignetteBackgroundImage.transform = growing ? CGAffineTransform(scaleX: 1.8, y: 1.8) : CGAffineTransform.identity
        }
        
        let circlesGrowAnimator = UIViewPropertyAnimator(duration: 0.4, controlPoint1: animationSettings.controlPoint1, controlPoint2: animationSettings.controlPoint2) { 
            animations(growing: true)
        }
        circlesGrowAnimator.startAnimation()
        circlesGrowAnimator.addCompletion { (_) in
            UIViewPropertyAnimator(duration: 0.38, controlPoint1: self.animationSettings.controlPoint1, controlPoint2: self.animationSettings.controlPoint2, animations: { 
                animations(growing: false)
            }).startAnimation()
        }
    }
    
    /// 背景碎花
    private func animateParticles() {
    
        UIViewPropertyAnimator(duration: 0.7, controlPoint1: animationSettings.controlPoint1, controlPoint2: animationSettings.controlPoint2) { 
            if self.toMoon {
                self.particlesView.center.x = self.particlesView.center.x - self.animationSettings.particlesVector.dx
                self.particlesView.center.y = self.particlesView.center.y - self.animationSettings.particlesVector.dy
                self.particlesView.transform = CGAffineTransform.identity
                self.particlesView.alpha = 0.6
            } else {
                self.particlesView.center.x = self.particlesView.center.x + self.animationSettings.particlesVector.dx
                self.particlesView.center.y = self.particlesView.center.y + self.animationSettings.particlesVector.dy
                self.particlesView.transform = CGAffineTransform(scaleX: 2, y: 2)
            }
        }.startAnimation()
    }
    
    private func animateHighliter() {
        iconsHighlighterView.animate(toRight: !toMoon)
        UIView.animate(withDuration: 0.56, delay: 0.0, options: .curveEaseInOut, animations: {
            self.highlighterContainer.center.x = self.highlighterContainer.center.x + (self.toMoon ? -1 : 1) * self.animationSettings.highlighterDistance
        }, completion: nil)
    }
    
    private func animateConstellationText() {
    
        UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseIn, animations: { 
            if self.toMoon {
                self.sunInAquariusView.alpha = 0
            } else {
                self.moonInLeoView.alpha = 0
            }
        }, completion: nil)
        UIView.animate(withDuration: 0.4, delay: 0.28, options: .curveEaseIn, animations: { 
            if self.toMoon {
                self.moonInLeoView.alpha = 1
            } else {
                self.sunInAquariusView.alpha = 1
            }
        }, completion: nil)
    }
}



















