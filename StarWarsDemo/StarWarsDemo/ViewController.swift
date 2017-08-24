//
//  ViewController.swift
//  StarWarsDemo
//
//  Created by ljb48229 on 2017/8/23.
//  Copyright © 2017年 ljb48229. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topLayoutConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        topLayoutConstraint.isActive = false
//        UIView.animate(withDuration: 2) {
//            
//            self.topLayoutConstraint.isActive = true
//            self.view.layoutIfNeeded()
//        }
        UIView.animate(withDuration: 1) {
            
            self.topLayoutConstraint.constant = 133;
            self.view.layoutIfNeeded()
        }
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(string: "123456")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

