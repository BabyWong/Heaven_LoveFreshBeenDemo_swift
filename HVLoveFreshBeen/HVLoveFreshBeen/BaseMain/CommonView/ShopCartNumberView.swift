//
//  ShopCartNumberView.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/9/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

class ShopCartNumberView: UIView {

    fileprivate static let instance = ShopCartNumberView()
    class var sharedShopCartNumberView: ShopCartNumberView {
        return instance
    }

    fileprivate var numberLable: UILabel? {
        let numLable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: mj_w, height: mj_h))
        numLable.backgroundColor = .red
        numLable.font = UIFont.systemFont(ofSize: 10)
        numLable.textColor = .white
        numLable.textAlignment = NSTextAlignment.center
        numLable.layer.cornerRadius = mj_w / 2.0
        numLable.layer.masksToBounds = true
        return numLable
    }
    var addShopCartNumber: Int = 0 {
        didSet {
            if 0 == addShopCartNumber {
                isHidden = true
                numberLable?.text = ""
            }else {
                if addShopCartNumber > 99 {
                    numberLable?.font = UIFont.systemFont(ofSize: 8)
                }else {
                    numberLable?.font = UIFont.systemFont(ofSize: 10)
                }
                isHidden = false
                numberLable?.text = "\(addShopCartNumber)"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: frame.origin.x, y: frame.origin.y, width: 20.0, height: 20.0))
        backgroundColor = .clear
        addSubview(numberLable!)
        isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        numberLable?.frame = CGRect.init(x: 0, y: 0, width: mj_w, height: mj_h)
    }
    //    MARK: 增加购物车
    func addProductToShopCart(animation: Bool) {
        addShopCartNumber = addShopCartNumber + 1
        if animation {
            shopCartNumberAnimation()
        }
    }
    
    //    Mark: 减少购物车
    func cutFromShopCary(animation: Bool) {
        if addShopCartNumber > 0 {
            addShopCartNumber = addShopCartNumber - 1
        }
        if animation {
            shopCartNumberAnimation()
        }
    }
    
    //    MARK: 购物车动画
    func shopCartNumberAnimation() {
        UIView.animate(withDuration: ShopCarRedDotAnimationDuration, animations: {
            self.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        }) { (Bool) in
            UIView.animate(withDuration: ShopCarRedDotAnimationDuration, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }
}
