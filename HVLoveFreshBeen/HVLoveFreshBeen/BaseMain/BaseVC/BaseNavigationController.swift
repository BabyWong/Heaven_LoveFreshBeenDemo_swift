//
//  BaseNavigationController.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/7/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    fileprivate lazy var backBtn:UIButton = {
        let backBtn = UIButton(type: UIButton.ButtonType.custom)
        backBtn.setImage(UIImage(named: "v2_goback"), for: UIControl.State())
        backBtn.titleLabel?.isHidden = true
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        backBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        backBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        let btnW: CGFloat = ScreenWidth > 375.0 ? 50 : 44
        backBtn.frame = CGRect(x: 0, y: 0, width: btnW, height: 40)
        return backBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            UINavigationBar.appearance().backItem?.hidesBackButton = false
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func backBtnClick() {
        popViewController(animated: true)
    }

}
