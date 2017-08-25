//
//  MainSettingViewController.swift
//  StarWarsDemo
//
//  Created by ljb48229 on 2017/8/25.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

class MainSettingViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    
    fileprivate var settingsViewController: SettingTableViewController?
    
    var theme: SettingsTheme! {
        didSet {
            settingsViewController?.theme = theme
            saveButton?.backgroundColor = theme.primaryColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "GothamPro", size: 20)!, NSForegroundColorAttributeName: UIColor.white]
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settings = segue.destination as? SettingTableViewController {
            settingsViewController = settings
            settings.themeChanged = { [unowned self, unowned settings]
                darkside, center in
                let center = self.view.convert(center, from: settings.view)
                self.view.animateCircular(withDuration: 0.5, center: center, revert: darkside ? false : true, animations: { 
                    self.theme = darkside ? .dark : .light
                }, completion: nil)
            }
        }
    }
 
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
