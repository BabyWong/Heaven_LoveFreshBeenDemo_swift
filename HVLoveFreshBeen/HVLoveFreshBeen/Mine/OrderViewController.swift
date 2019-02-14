//
//  OrderViewController.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/11/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

class OrderViewController: BaseViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的订单"
    }

}
