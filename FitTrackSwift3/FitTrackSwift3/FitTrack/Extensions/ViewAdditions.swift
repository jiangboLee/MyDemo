//
//  ViewAdditions.swift
//  FitTrackSwift3
//
//  Created by ljb48229 on 2017/8/28.
//  Copyright © 2017年 ljb48229. All rights reserved.
//

import UIKit

extension UIView {

    func roundSpecificCorners(_ corners: UIRectCorner, cornerRadius: CGFloat) {
    
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    //声明函数时，在参数前面用inout修饰，函数内部实现改变外部参数传入参数时(调用函数时)，在变量名字前面用 & 符号修饰表示，表明这个变量在参数内部是可以被改变的（可将改变传递到原始数据）inout修饰的参数是不能有默认值的，有范围的参数集合也不能被修饰；
    //一个参数一旦被inout修饰，就不能再被var和let修饰了。
    func xibSetup(_ subView: inout UIView?, nibName: String) {
        
        subView = loadViewFromNib(nibName)
        subView?.frame = bounds
        subView?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(subView!)
    }
    
    fileprivate func loadViewFromNib(_ nibName: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
        
    }
}



