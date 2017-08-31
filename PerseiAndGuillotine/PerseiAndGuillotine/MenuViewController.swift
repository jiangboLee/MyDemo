//
//  MenuViewController.swift
//  PerseiAndGuillotine
//
//  Created by ljb48229 on 2017/8/31.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, GuillotineMenu {

    var dismissButton: UIButton?
    var titleLable: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissButton = {
            let button = UIButton(frame: .zero)
            button.setImage(#imageLiteral(resourceName: "ic_menu.png"), for: .normal)
            button.addTarget(self, action: #selector(dismissButtonTapped(_:)), for: .touchUpInside)
            return button
        }()
        
        titleLable = {
            let lable = UILabel()
            lable.numberOfLines = 1
            lable.text = "Activity"
            lable.font = UIFont.boldSystemFont(ofSize: 17)
            lable.textColor = .white
            lable.sizeToFit()
            return lable
        }()
    }
    
    func dismissButtonTapped(_ sender: UIButton) {
        presentingViewController!.dismiss(animated: true, completion: nil)
    }
}

extension MenuViewController: GuillotineAnimationDelegate {

    func animatorDidFinishPresentation(_ animator: GuillotineTransitionAnimation) {
        print("menuDidFinishPresentation")
    }
    func animatorDidFinishDismissal(_ animator: GuillotineTransitionAnimation) {
        print("menuDidFinishDismissal")
    }
    
    func animatorWillStartPresentation(_ animator: GuillotineTransitionAnimation) {
        print("willStartPresentation")
    }
    
    func animatorWillStartDismissal(_ animator: GuillotineTransitionAnimation) {
        print("willStartDismissal")
    }
}






