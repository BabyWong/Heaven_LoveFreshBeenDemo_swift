//
//  HVRefreshHeader.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/8/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

class HVRefreshHeader: MJRefreshGifHeader {

    override func prepare() {
        
        super.prepare()
        
        stateLabel.isHidden = false
        setImages([UIImage.init(named: "v2_pullRefresh1")!], for: MJRefreshState.idle)
        setImages([UIImage.init(named: "v2_pullRefresh2")!], for: MJRefreshState.pulling)
        setImages([UIImage.init(named: "v2_pullRefresh1")!,UIImage(named: "v2_pullRefresh2")!], for: MJRefreshState.refreshing)
        
        setTitle("正在刷新", for: MJRefreshState.idle)
        setTitle("松手立即刷新", for: MJRefreshState.pulling)
        setTitle("正在刷新", for: MJRefreshState.refreshing)
    }
    
}
