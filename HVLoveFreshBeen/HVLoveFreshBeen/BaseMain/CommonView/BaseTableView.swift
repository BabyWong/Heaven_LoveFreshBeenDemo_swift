//
//  BaseTableView.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/10/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        delaysContentTouches = false // 延迟触摸 false
        canCancelContentTouches = true // 允许取消触摸
        separatorStyle = .none
        let wrapView = subviews.first // 包装第一个组件view
        if wrapView != nil {
            if NSStringFromClass((wrapView?.classForCoder)!).hasPrefix("WrapperView") {
                for gesture in (wrapView?.gestureRecognizers!)! {
                    if NSStringFromClass(gesture.classForCoder).contains("DelayedTouchesBegan") {
                        gesture.isEnabled = false
                        break
                    }
                }
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view.isKind(of: UIControl.self) {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
    
}
