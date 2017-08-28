//
//  ViewController.swift
//  FitTrackSwift3
//
//  Created by ljb48229 on 2017/8/28.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    
    @IBOutlet weak var activityTableView: UITableView!
    
    @IBOutlet weak var helperView: UIView!
    
    @IBOutlet weak var activityTableViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var activityTableViewTrailingContraint: NSLayoutConstraint!
    
    fileprivate var backgroundHeaderSectionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundHeaderSectionView = UIView(frame: helperView.frame)
        animationView.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width - activityTableViewLeadingConstraint.constant + activityTableViewTrailingContraint.constant, height: view.frame.height)
        
        setTitleView()
        setupTableView()
    }
    
    fileprivate func setTitleView() {
        let logo = #imageLiteral(resourceName: "myDayFit")
        let imageView = UIImageView(image: logo)
        navigationItem.titleView = imageView
    }
    
    fileprivate func setupTableView() {
        activityTableView.register(ActivityTableViewCell.cellNib, forCellReuseIdentifier: ActivityTableViewCell.id)
        activityTableView.register(TableHeaderSectionView.cellNib, forCellReuseIdentifier: TableHeaderSectionView.id)
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
    }
    
    fileprivate func configureAnimationView() {
        let activities = ActivityDataProvider.generateAcitivities()
        animationView.
    }
    

}





