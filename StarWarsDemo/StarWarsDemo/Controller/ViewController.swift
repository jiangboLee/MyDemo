//
//  ViewController.swift
//  StarWarsDemo
//
//  Created by ljb48229 on 2017/8/23.
//  Copyright © 2017年 ljb48229. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    //weak改成fileprivate ，🐂！！！！
    @IBOutlet fileprivate var topLayoutConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topLayoutConstraint.isActive = false

//        UIView.animate(withDuration: 1) {
//            
//            self.topLayoutConstraint.constant = 133;
//            self.view.layoutIfNeeded()
//        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1) {
            
            self.topLayoutConstraint.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func setupYourProfileTapped(_ sender: PrifileButton) {
        sender.animateTouchUpInside { 
            self.performSegue(withIdentifier: "presentSettings", sender: sender)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        destination.transitioningDelegate = self
        if let navigation = destination as? UINavigationController,
            let settings = navigation.topViewController as? MainSettingViewController {
           settings.theme = .light
        }
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        
//    }
}

