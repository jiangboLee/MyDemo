//
//  CellInterface.swift
//  FitTrackSwift3
//
//  Created by ljb48229 on 2017/8/28.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

protocol CellInterface {
    
    static var id: String { get }
    static var cellNib: UINib { get }
}

extension CellInterface {

    static var id: String {
        return String(describing: Self.self)
    }
    
    static var cellNib: UINib {
        return UINib(nibName: id, bundle: nil)
    }
}
