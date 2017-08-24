//
//  AnimationDelegate.swift
//  StarWarsDemo
//
//  Created by ljb48229 on 2017/8/24.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

class AnimationDelegate: NSObject, CAAnimationDelegate {
    
    fileprivate let completion: () -> Void
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        completion()
    }
}
