//
//  AnimationView.swift
//  FitTrackSwift3
//
//  Created by ljb48229 on 2017/8/28.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

class AnimationView: UIView {

    @IBOutlet
    internal weak var activityContainerView: ActivityContainerView!
    
    fileprivate var activities: [Activity]?
    fileprivate var currentActiveRoundButtonTag = 0
    fileprivate var subview: UIView?

}
