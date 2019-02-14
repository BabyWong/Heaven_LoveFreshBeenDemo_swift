//
//  ButtonExtension.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/10/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

class UpImageDownTextButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRect.init(x: 0.0, y: mj_h - 15.0, width: mj_w, height: (titleLabel?.mj_h)!)
        titleLabel?.textAlignment = .center
        imageView?.frame = CGRect.init(x: 0.0, y: 0.0, width: mj_w, height: mj_h - 15.0)
        imageView?.contentMode = UIView.ContentMode.center
    }
}

class ItemRightButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        let offset: CGFloat = 15.0
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRect.init(x: offset, y: mj_h - 15, width: mj_w + offset, height: (titleLabel?.mj_h)!)
        titleLabel?.textAlignment = .center
        imageView?.frame = CGRect.init(x: offset, y: 0, width: mj_w + offset, height: mj_h - 15)
        imageView?.contentMode = UIView.ContentMode.center
    }
}

