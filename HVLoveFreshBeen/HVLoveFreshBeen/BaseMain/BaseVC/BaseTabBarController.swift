//
//  BaseTabBarController.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/7/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

class BaseTabBarController: AnimationTabBarController, UITabBarControllerDelegate {

    fileprivate var fristLoadMainTabBarController: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        addAllVC()
//        setItemThem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if fristLoadMainTabBarController {
            let containers = createViewContainers()
            createCustomIcons(containers)
            fristLoadMainTabBarController = false
        }
    }
    
    func addAllVC() {
        addChildOne(viewController: HomeVC(), titleName: "首页", imagName: "v2_home", tag: 0)
        addChildOne(viewController: SuperMarketVC(), titleName: "闪电超市", imagName: "v2_order", tag: 1)
        addChildOne(viewController: ShopCartVC(), titleName: "购物车", imagName: "shopCart", tag: 2)
        addChildOne(viewController: MineVC(), titleName: "我的", imagName: "v2_my", tag: 3)
    }
    
    func addChildOne(viewController: UIViewController, titleName: String, imagName: String, tag: Int) {
        
        let vcItem = HVAnimatedTabBarItem(title: titleName, image: UIImage.init(named: imagName), selectedImage: UIImage.init(named: "\(imagName)"))
        vcItem.tag = tag
        vcItem.isAnimation = false
        vcItem.animation = HVBounceAnimation()
        viewController.title = titleName
//        viewController.tabBarItem.image = UIImage.init(named: imagName)
//        viewController.tabBarItem.selectedImage = UIImage.init(named: "\(imagName)_r")
//        viewController.tabBarController?.tabBar.isTranslucent = false
        viewController.tabBarItem = vcItem
        let nav = BaseNavigationController.init(rootViewController: viewController)
        addChild(nav)
    }
    
    override func setToolbarItems(_ toolbarItems: [UIBarButtonItem]?, animated: Bool) {
    }
    
//    func setItemThem() {
//        tabBar.tintColor = BaseNavigationYellowColor
//        tabBar.isTranslucent = false
//    }

}


