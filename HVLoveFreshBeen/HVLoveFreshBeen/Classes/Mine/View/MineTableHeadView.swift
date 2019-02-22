//
//  MineTableHeadView.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/10/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

enum MineHeadViewButtonType: Int {
    case order = 0
    case coupon = 1
    case message = 2
}

class MineTableHeadView: UIView {
    
    var mineTableHeadViewBlock: ((_ type: MineHeadViewButtonType) -> ())?
    fileprivate var couponNumber: UIButton?
    fileprivate let ordereView = MineOrderView()
    fileprivate let couponView = MineCouponView()
    fileprivate let messageView = MineMessageView()
    fileprivate let line1 = UIView()
    fileprivate let line2 = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let subViewW = mj_w / 3.0
        let height = mj_h
        ordereView.frame = CGRect(x: 0, y: 0, width: subViewW, height: height)
        couponView.frame = CGRect(x: subViewW, y: 0, width: subViewW, height: height)
        messageView.frame = CGRect(x: subViewW * 2, y: 0, width: subViewW, height: height)
        couponNumber?.frame = CGRect(x: subViewW * 1.56, y: 12, width: 15, height: 15)
        line1.frame = CGRect(x: subViewW - 0.5, y: height * 0.2, width: 1, height: height * 0.6)
        line2.frame = CGRect(x: subViewW * 2 - 0.5, y: height * 0.2, width: 1, height: height * 0.6)
    }
    
    fileprivate func buildUI() {
        
        ordereView.tag = MineHeadViewButtonType.order.rawValue
        addSubview(ordereView)
        
        couponView.tag = MineHeadViewButtonType.coupon.rawValue
        addSubview(couponView)
        
        messageView.tag = MineHeadViewButtonType.message.rawValue
        addSubview(messageView)
        
        for index in 0...2 {
            let tap = UITapGestureRecognizer(target: self, action: #selector(click(tap:)))
            let subView = viewWithTag(index)
            subView?.addGestureRecognizer(tap)
        }
        
        line1.backgroundColor = UIColor.gray
        line1.alpha = 0.3
        addSubview(line1)
        
        line2.backgroundColor = UIColor.gray
        line2.alpha = 0.3
        addSubview(line2)
        
        couponNumber = UIButton(type: .custom)
        couponNumber?.setBackgroundImage(UIImage(named: "redCycle"), for: UIControl.State())
        couponNumber?.setTitleColor(UIColor.red, for: UIControl.State())
        couponNumber?.isUserInteractionEnabled = false
        couponNumber?.titleLabel?.font = UIFont.systemFont(ofSize: 8)
        couponNumber?.isHidden = true
        addSubview(couponNumber!)
    }
    
    @objc fileprivate func click(tap: UIGestureRecognizer) {
        if mineTableHeadViewBlock != nil {
            mineTableHeadViewBlock!(MineHeadViewButtonType(rawValue: tap.view!.tag)!)
//            switch tap.view!.tag {
//            case MineHeadViewButtonType.order.rawValue:
//                mineTableHeadViewBlock!(MineHeadViewButtonType.order)
//                break
//            case MineHeadViewButtonType.coupon.rawValue:
//                break
//            case MineHeadViewButtonType.message.rawValue:
//                break
//            default:
//                break
//            }
        }
    }
    
    func setCouponNumber(_ number: Int) {
        if number > 0 && number <= 9 {
            couponNumber?.isHidden = false
            couponNumber?.setTitle("\(number)", for: UIControl.State())
        } else if number > 9 && number < 100 {
            couponNumber?.setTitle("\(number)", for: UIControl.State())
            couponNumber?.isHidden = false
        } else {
            couponNumber?.isHidden = true
        }
    }
}

class MineOrderView: UIView {
    var btn: MineUpImageDownText!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        btn = MineUpImageDownText.init(frame: .zero, title: "我的订单", imageName: "v2_my_order_icon")
        addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.frame = CGRect(x: 10, y: 10, width: mj_w - 20, height: mj_h - 20)
    }
    
}


class MineCouponView: UIView {
    var btn: UpImageDownTextButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        btn = MineUpImageDownText.init(frame: .zero, title: "优惠券", imageName: "v2_my_coupon_icon")
        addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.frame = CGRect(x: 10, y: 10, width: mj_w - 20, height: mj_h - 20)
    }
}

class MineMessageView: UIView {
    var btn: UpImageDownTextButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        btn = MineUpImageDownText(frame: CGRect.zero, title: "我的消息", imageName: "v2_my_message_icon")
        addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.frame = CGRect(x: 10, y: 10, width: mj_w - 20, height: mj_h - 20)
    }
}

// 继承
class MineUpImageDownText: UpImageDownTextButton {
    // 构造函数
    init(frame: CGRect, title: String, imageName: String) {
        super.init(frame: frame)
        setTitle(title, for: .normal)
        setImage(UIImage.init(named: imageName), for: .normal)
        setTitleColor(.colorWithCustom(80, g: 80, b: 80, alpha: 1.0), for: .normal)
        isUserInteractionEnabled = false
        titleLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
