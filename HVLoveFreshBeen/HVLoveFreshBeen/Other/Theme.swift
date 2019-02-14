//
//  Theme.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/3/19.
//  Copyright © 2019 cenntro. All rights reserved.
//  全局 --- .pch的等价替代

import UIKit

// MARK: 全局常用属性
public let ScreenWidth: CGFloat = UIScreen.main.bounds.width
public let ScreenHeight: CGFloat = UIScreen.main.bounds.height
public let ScreenBounds: CGRect = UIScreen.main.bounds
public let StatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
public let NavigationBarHeight: CGFloat = 64.0
public let ShopCarRedDotAnimationDuration: TimeInterval = 0.2// 购物车动画时间

// MARK: 通用间距
public let Margin: NSInteger = 10

// MARK: 常用颜色
public let BaseBackGroundColor: UIColor = UIColor.colorWithCustom(2329, g: 239, b: 239, alpha: 1)
public let BaseNavigationYellowColor = UIColor.colorWithCustom(253, g: 212, b: 49, alpha:1)
public let BaseTextGreyColol = UIColor.colorWithCustom(130, g: 130, b: 130, alpha:1)
public let BaseTextBlackColor = UIColor.colorWithCustom(50, g: 50, b: 50, alpha:1)


// MARK: - HTMLURL
///优惠劵使用规则
public let CouponUserRuleURLString = "http://m.beequick.cn/show/webview/p/coupon?zchtauth=e33f2ac7BD%252BaUBDzk6f5D9NDsFsoCcna6k%252BQCEmbmFkTbwnA&__v=ios4.7&__d=d14ryS0MFUAhfrQ6rPJ9Gziisg%2F9Cf8CxgkzZw5AkPMbPcbv%2BpM4HpLLlnwAZPd5UyoFAl1XqBjngiP6VNOEbRj226vMzr3D3x9iqPGujDGB5YW%2BZ1jOqs3ZqRF8x1keKl4%3D"
// AuthorURL
public let GitHubURLString: String = "https://github.com/ZhongTaoTian"
public let SinaWeiBoURLString: String = "http://weibo.com/tianzhongtao"
public let BlogURLString: String = "http://www.jianshu.com/users/5fe7513c7a57/latest_articles"

// MARK: - Cache路径
public let HVCachePath: String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
