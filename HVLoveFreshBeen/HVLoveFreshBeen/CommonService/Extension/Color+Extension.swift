//
//  Color+Extension.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/3/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

extension UIColor {
    class func colorWithCustom(_ r: CGFloat, g:CGFloat, b:CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
}
