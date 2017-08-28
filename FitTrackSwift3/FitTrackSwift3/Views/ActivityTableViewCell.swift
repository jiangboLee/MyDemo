//
//  ActivityTableViewCell.swift
//  FitTrackSwift3
//
//  Created by ljb48229 on 2017/8/28.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell, CellInterface {

    @IBOutlet
    fileprivate weak var backgroundImageView: UIImageView!
    
    func setBackgroundImage(_ image: UIImage) {
        backgroundImageView.image = image
        
    }
}
