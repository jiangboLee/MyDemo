//
//  SettingTableViewController.swift
//  StarWarsDemo
//
//  Created by ljb48229 on 2017/8/25.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

private let TableViewOffset: CGFloat = UIScreen.main.bounds.height < 600 ? 215 : 225
private let BeforeAppearOffset: CGFloat = 400

class SettingTableViewController: UITableViewController {

    var themeChanged: ((_ darkside: Bool, _ center: CGPoint) -> Void)?
    
    @IBOutlet var backgroundHolder: UIView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var backgroundHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backgroundWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var darkSideSwitch: UISwitch!
    
    @IBOutlet weak var radioInctiveImageView: UIImageView!
    
    @IBOutlet weak var radioActiveImageiew: UIImageView!
    
    @IBOutlet fileprivate var cellTitleLabels: [UILabel]!
    @IBOutlet fileprivate var cellSubtitleLabels: [UILabel]!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBAction func darkSideChanged(_ sender: UISwitch) {
        
        let center = self.tableView.convert(darkSideSwitch.center, from: darkSideSwitch.superview)
        self.themeChanged?(darkSideSwitch.isOn, center)
    }
    
    var theme: SettingsTheme! {
        didSet {
            backgroundImageView.image = theme.topImage
            tableView.separatorColor = theme.separatorColor
            backgroundHolder.backgroundColor = theme.backgroundColor
            for label in cellTitleLabels {
                label.textColor = theme.cellTitleColor
            }
            for label in cellSubtitleLabels {
                label.textColor = theme.cellSubtitleColor
            }
            radioInctiveImageView.image = theme.radioInactiveImage
            radioActiveImageiew.image = theme.radioActiveImage
            usernameLabel.text = theme.username
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsetsMake(TableViewOffset, 0, 0, 0)
        tableView.contentOffset = CGPoint(x: 0, y: -BeforeAppearOffset)
        
        UIView.animate(withDuration: 0.5) { 
            self.tableView.contentOffset = CGPoint(x: 0, y: -TableViewOffset)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        theme = .light
        tableView.backgroundView = backgroundHolder
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = theme.backgroundColor
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        backgroundHeightConstraint.constant = max(navigationController!.navigationBar.bounds.height + scrollView.contentInset.top - scrollView.contentOffset.y, 0)
        backgroundWidthConstraint.constant = navigationController!.navigationBar.bounds.height - scrollView.contentInset.top - scrollView.contentOffset.y * 0.8
    }

}


