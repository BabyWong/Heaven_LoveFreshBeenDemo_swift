//
//  AnimationTabBarController.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/14/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

class AnimationTabBarController: UITabBarController {
    
    var iconsView: [(icon: UIImageView, textLabel: UILabel)] = []
    var iconsImageName:[String] = ["v2_home", "v2_order", "shopCart", "v2_my"]
    var iconsSelectedImageName:[String] = ["v2_home_r", "v2_order_r", "shopCart_r", "v2_my_r"]
    var shopCarIcon: UIImageView?
    var isPlayAnimation: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        NotificationCenter.default.addObserver(self, selector: Selector(("searchViewControllerDeinit")), name: NSNotification.Name(rawValue: "LFBSearchViewControllerDeinit"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func searchViewControllerDeinit() {
        if shopCarIcon != nil {
            let redDotView = ShopCartNumberView.sharedShopCartNumberView
            redDotView.frame = CGRect(x: 21 + 1, y: -3, width: 15, height: 15)
            shopCarIcon?.addSubview(redDotView)
        }
    }
    
    func createViewContainers() -> [String: UIView] {
        var containersDict = [String: UIView]()
        
        guard let customItems = tabBar.items as? [HVAnimatedTabBarItem] else
        {
            return containersDict
        }
        
        for index in 0..<customItems.count {
            let viewContainer = createViewContainer(index)
            containersDict["container\(index)"] = viewContainer
        }
        
        return containersDict
    }
    
    func createViewContainer(_ index: Int) -> UIView {
        
        let viewWidth: CGFloat = ScreenWidth / CGFloat(tabBar.items!.count)
        let viewHeight: CGFloat = tabBar.bounds.size.height
        
        let viewContainer = UIView(frame: CGRect(x: viewWidth * CGFloat(index), y: 0, width: viewWidth, height: viewHeight))
        
        viewContainer.backgroundColor = UIColor.clear
        viewContainer.isUserInteractionEnabled = true
        
        tabBar.addSubview(viewContainer)
        viewContainer.tag = index
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tabBar(_:didSelect:)))
        viewContainer.addGestureRecognizer(tap)
        
        return viewContainer
    }
    
    //    @objc func tabBarClick(_ tap: UITapGestureRecognizer ) {
    //
    //    }
    
    
    func createCustomIcons(_ containers : [String: UIView]) {
        if let items = tabBar.items {
            
            for (index, item) in items.enumerated() {
                
                assert(item.image != nil, "add image icon in UITabBarItem")
                
                guard let container = containers["container\(index)"] else
                {
                    print("No container given")
                    continue
                }
                
                container.tag = index
                
                let imageW:CGFloat = 21
                let imageX:CGFloat = (ScreenWidth / CGFloat(items.count) - imageW) * 0.5
                let imageY:CGFloat = 8
                let imageH:CGFloat = 21
                let icon = UIImageView(frame: CGRect(x: imageX, y: imageY, width: imageW, height: imageH))
                icon.image = item.image
                icon.tintColor = UIColor.clear
                
                
                // text
                let textLabel = UILabel()
                textLabel.frame = CGRect(x: 0, y: 32, width: ScreenWidth / CGFloat(items.count), height: 49 - 32)
                textLabel.text = item.title
                textLabel.backgroundColor = UIColor.clear
                textLabel.font = UIFont.systemFont(ofSize: 10)
                textLabel.textAlignment = NSTextAlignment.center
                textLabel.textColor = UIColor.gray
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                container.addSubview(icon)
                container.addSubview(textLabel)
                
                
                if let tabBarItem = tabBar.items {
                    let textLabelWidth = tabBar.frame.size.width / CGFloat(tabBarItem.count)
                    textLabel.bounds.size.width = textLabelWidth
                }
                
                if 2 == index {
                    let redDotView = ShopCartNumberView.sharedShopCartNumberView
                    redDotView.frame = CGRect(x: imageH + 1, y: -3, width: 15, height: 15)
                    icon.addSubview(redDotView)
                    shopCarIcon = icon
                }
                
                let iconsAndLabels = (icon:icon, textLabel:textLabel)
                iconsView.append(iconsAndLabels)
                
                
                item.image = nil
                item.title = ""
                
                if index == 0 {
                    selectedIndex = 0
                    selectItem(0)
                }
            }
        }
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        setSelectIndex(from: selectedIndex, to: item.tag)
    }
    
    func selectItem(_ Index: Int) {
        let items = tabBar.items as! [HVAnimatedTabBarItem]
        let selectIcon = iconsView[Index].icon
        selectIcon.image = UIImage(named: iconsSelectedImageName[Index])!
        items[Index].selectedState(selectIcon, textLabel: iconsView[Index].textLabel)
    }
    
    func setSelectIndex(from: Int,to: Int) {
        
//        if to == 2 {
//            let vc = children[selectedIndex]
//            let shopCar = ShopCartVC()
//            let nav = BaseNavigationController(rootViewController: shopCar)
//            vc.present(nav, animated: true, completion: nil)
//
//            return
//        }
        
        selectedIndex = to
        let items = tabBar.items as! [HVAnimatedTabBarItem]
        
        let fromIV = iconsView[from].icon
        fromIV.image = UIImage(named: iconsImageName[from])
        items[from].deselectAnimation(fromIV, textLabel: iconsView[from].textLabel)
        
        let toIV = iconsView[to].icon
        toIV.image = UIImage(named: iconsSelectedImageName[to])
        items[to].playAnimation(toIV, textLabel: iconsView[to].textLabel, isPlayAnimation: isPlayAnimation)
    }
}


// MARK: 组件

class HVBounceAnimation : HVItemAnimation {
    
    override func playAnimation(_ icon : UIImageView, textLabel : UILabel, isPlayAnimation: Bool) {
        textLabel.textColor = textSelectedColor
        if isPlayAnimation {
            playBounceAnimation(icon)
        }
  
    }
    
    override func deselectAnimation(_ icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor) {
        textLabel.textColor = defaultTextColor
        
        if let iconImage = icon.image {
            let renderImage = iconImage.withRenderingMode(.alwaysOriginal)
            icon.image = renderImage
            icon.tintColor = defaultTextColor
            
        }
    }
    
    override func selectedState(_ icon : UIImageView, textLabel : UILabel) {
        textLabel.textColor = textSelectedColor
        
        if let iconImage = icon.image {
            let renderImage = iconImage.withRenderingMode(.alwaysOriginal)
            icon.image = renderImage
            icon.tintColor = textSelectedColor
        }
    }
    
    func playBounceAnimation(_ icon : UIImageView) {
        
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(duration)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        
        icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
        
        if let iconImage = icon.image {
            let renderImage = iconImage.withRenderingMode(.alwaysOriginal)
            icon.image = renderImage
            icon.tintColor = iconSelectedColor
        }
    }
    
}


class HVAnimatedTabBarItem: UITabBarItem {
    
    var animation: HVItemAnimation?
    /// 是否开启动画 默认开启
    var isAnimation: Bool = true
    var textColor = UIColor.gray
    
    func playAnimation(_ icon : UIImageView, textLabel : UILabel, isPlayAnimation: Bool) {
        guard let animation = animation else {
            print("add animation in UITabBarItem")
            return
        }
        animation.playAnimation(icon, textLabel: textLabel, isPlayAnimation: isAnimation)
    }
    
    func deselectAnimation(_ icon: UIImageView, textLabel: UILabel) {
        animation?.deselectAnimation(icon, textLabel: textLabel, defaultTextColor: textColor)
    }
    
    func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        animation?.selectedState(icon, textLabel: textLabel)
    }
}

protocol HVItemAnimationProtocol {
    
    func playAnimation(_ icon : UIImageView, textLabel : UILabel, isPlayAnimation: Bool)
    func deselectAnimation(_ icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor)
    func selectedState(_ icon : UIImageView, textLabel : UILabel)
}

class HVItemAnimation: NSObject, HVItemAnimationProtocol {
    
    var duration : CGFloat = 0.6
    var textSelectedColor: UIColor = BaseNavigationYellowColor
    var iconSelectedColor: UIColor?
    
    func playAnimation(_ icon : UIImageView, textLabel : UILabel, isPlayAnimation: Bool) {
    }
    
    func deselectAnimation(_ icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor) {
        
    }
    
    func selectedState(_ icon: UIImageView, textLabel : UILabel) {
    }
    
}
