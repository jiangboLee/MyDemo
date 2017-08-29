//
//  ViewController.swift
//  FitTrackSwift3
//
//  Created by ljb48229 on 2017/8/28.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

private let ratioCoefficient: CGFloat = 3.117
private let tableHeaderSectionViewHeight: CGFloat = 114.0
private let tableCellHeight: CGFloat = 105.0
private let rowsCount = 10
private let tableHeaderSectionViewHeightDelta: CGFloat = 64.0
private let animationDuration: TimeInterval = 0.3
private let maxHeaderSectionAlphaValue: CGFloat = 0.95
private let cornerRadius: CGFloat = 12.0

private enum HeaderSectionState {
    case visibleState
    case unvisibleState
}

class ViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    
    @IBOutlet weak var activityTableView: UITableView!
    
    @IBOutlet weak var helperView: UIView!
    
    @IBOutlet weak var activityTableViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var activityTableViewTrailingContraint: NSLayoutConstraint!
    
    fileprivate var backgroundHeaderSectionView: UIView!
    fileprivate var tableHeaderSectionView: TableHeaderSectionView!
    fileprivate var headerSectionState = HeaderSectionState.unvisibleState
    
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
        activityTableView.register(TableHeaderSectionView.cellNib, forHeaderFooterViewReuseIdentifier: TableHeaderSectionView.id)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureAnimationView()
        let delayTime = DispatchTime.now() + Double(Int64(0.3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC) // perform animation after 0.3 s
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.animationView.performAnimation()
        }
    }
    
    fileprivate func configureAnimationView() {
        let activities = ActivityDataProvider.generateAcitivities()
        animationView.configureSubviews(activities.count, activities: activities)
        animationView.animationFirstPhaseDidFinish = {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(animationDuration)
            self.animationView.frame = CGRect(x: 0.0, y: 0.0, width: self.animationView.frame.width, height: self.animationView.frame.height - (self.animationView.frame.height / ratioCoefficient) - tableHeaderSectionViewHeightDelta)
            self.activityTableView.tableHeaderView = self.animationView
            self.navigationController!.isNavigationBarHidden = false
            UIView.commitAnimations()
        }
    }
    
    // MARK - UITableViewDatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.id, for: indexPath)
        return cell
    }
    
    // MARK - UITableViewDelegate
    func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        let activityTableViewCell = cell as! ActivityTableViewCell
        if indexPath.row == 0 {
            activityTableViewCell.setBackgroundImage(#imageLiteral(resourceName: "bg_white_top"))
        } else if indexPath.row == rowsCount - 1 {
            activityTableViewCell.setBackgroundImage(#imageLiteral(resourceName: "bg_white_bottom"))
            cell.clipsToBounds = true
        } else {
            activityTableViewCell.setBackgroundImage(#imageLiteral(resourceName: "bg_white_middle"))
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerSction = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeaderSectionView.id) as! TableHeaderSectionView
        tableHeaderSectionView = headerSction
        backgroundHeaderSectionView.backgroundColor = UIColor.clear
        tableHeaderSectionView.backgroundView = backgroundHeaderSectionView
        return headerSction
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableHeaderSectionViewHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return tableCellHeight
    }
    
    // MARK - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView!) {
        if scrollView.contentOffset.y > 0 {
            animationView.alpha = 1 - scrollView.contentOffset.y / animationView.frame.height
            helperView.alpha = min(1 - animationView.alpha, maxHeaderSectionAlphaValue)
            if animationView.alpha <= 0 && headerSectionState == HeaderSectionState.unvisibleState {
                backgroundHeaderSectionView.backgroundColor = helperView.backgroundColor?.withAlphaComponent(maxHeaderSectionAlphaValue)
                tableHeaderSectionView.backgroundView = backgroundHeaderSectionView
                headerSectionState = HeaderSectionState.visibleState
            } else if animationView.alpha > 0 && headerSectionState == HeaderSectionState.visibleState {
                backgroundHeaderSectionView.backgroundColor = UIColor.clear
                tableHeaderSectionView.backgroundView = backgroundHeaderSectionView
                headerSectionState = HeaderSectionState.unvisibleState
            }
        } else {
            helperView.alpha = 0
            animationView.alpha = 1
        }
        
    }


}





