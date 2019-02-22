//
//  HomeHeadView.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 2/22/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

class HomeHeadView: UIView {
    
    fileprivate var pageScrollView: PageScrollView?
    fileprivate var hotView: HomeHotView?
    weak var delegate: HomeTableHeadViewDelegate?
    var tableHeadViewHeight: CGFloat = 0 {
        willSet {
            NotificationCenter.default.post(name: Notification.Name(rawValue: HomeTableHeadViewHeightDidChange), object: newValue)
            frame = CGRect(x: 0, y: -newValue, width: ScreenWidth, height: newValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildPageScrollView()
        buildHotView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 模型的set方法
    var headData: HeadResources? {
        didSet {
            pageScrollView?.headData = headData
            hotView!.headData = headData?.data
        }
    }
    // MARK: 初始化子控件
    func buildPageScrollView() {
        weak var tmpSelf = self
        pageScrollView = PageScrollView(frame: CGRect.zero, placeholder: UIImage(named: "v2_placeholder_full_size")!, focusImageViewClick: { (index) -> Void in
            if tmpSelf!.delegate != nil && ((tmpSelf!.delegate?.responds(to: #selector(HomeTableHeadViewDelegate.tableHeadView(_:focusImageViewClick:)))) != nil) {
                tmpSelf!.delegate!.tableHeadView!(tmpSelf!, focusImageViewClick: index)
            }
        })
        
        addSubview(pageScrollView!)
    }
    
    func buildHotView() {
        weak var tmpSelf = self
        hotView = HomeHotView(frame: CGRect.zero, iconClick: { (index) -> Void in
            if tmpSelf!.delegate != nil && ((tmpSelf!.delegate?.responds(to: #selector(HomeTableHeadViewDelegate.tableHeadView(_:iconClick:)))) != nil) {
                tmpSelf!.delegate!.tableHeadView!(tmpSelf!, iconClick: index)
            }
        })
        hotView?.backgroundColor = .white
        addSubview(hotView!)
    }
    
    //MARK: 布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pageScrollView?.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth * 0.31)
        
        hotView?.frame.origin = CGPoint(x: 0, y: (pageScrollView?.frame)!.maxY)
        
        tableHeadViewHeight = hotView!.frame.maxY
    }
}

// - MARK: Delegate
@objc protocol HomeTableHeadViewDelegate: NSObjectProtocol {
    @objc optional func tableHeadView(_ headView: HomeHeadView, focusImageViewClick index: Int)
    @objc optional func tableHeadView(_ headView: HomeHeadView, iconClick index: Int)
}
