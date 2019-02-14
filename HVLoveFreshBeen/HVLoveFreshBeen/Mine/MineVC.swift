//
//  MineVC.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/9/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

class MineVC: BaseViewController {
    
    //    MARK: 属性
    fileprivate var mineHeadView: MineHeadView!
    fileprivate var tableView: BaseTableView!
    fileprivate let headViewHeight: Int = Int(StatusBarHeight + 130)
    fileprivate var tableHeadView: MineTableHeadView?
    fileprivate var couponNum: Int = 0
    /// tag
    var iderVCSendIderSuccess = false
    
    fileprivate lazy var mineModel:[MineCellModel] = {
        let mineModel = MineCellModel.loadMineCellModel()
        return mineModel
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
//        DataManager.shareDataManager().token(type: .DataManager_ENUM_TYPE_REMOVE, value: "123heaven")
        DataManager.shareDataManager().tokenUpdate(type: .DataManager_ENUM_TYPE_SAVE, value: "123heaven")
        let token = DataManager.shareDataManager().getToken()
        print(token)
        
//        DataServices.shareDataServices().saveUserInfo(userInfo: [["name":"heaven"],["age":"12"]])
//        let userinfo = DataServices.shareDataServices().getUserInfo()
//        print(userinfo)
        
//        LoginModel.requestLogin(email: "123@qq.com", password: "123456") { (ResponseDate, LoginModel) in
//            print("请求成功 email:")
//            print(LoginModel.email)
//            print(LoginModel.fullName ?? "")
//            DataServices.shareDataServices().saveToken(LoginModel.token!)
//
//            let token = DataServices.shareDataServices().getToken()
//            print(token)
//        }
        
        
//        LoginModel.requestOutLogin { (ResponseDate) in
//            print(ResponseDate.state)
//        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
        weak var weakSelf = self
        MineModel.loadMineData { (minData, error) in
            if error != nil {
                if (minData?.data?.availble_coupon_num)! > 0 {
                    weakSelf?.couponNum = (minData?.data?.availble_coupon_num)!
                    weakSelf?.tableHeadView?.setCouponNumber((minData?.data?.availble_coupon_num)!)
                }else {
                    weakSelf?.tableHeadView?.setCouponNumber(0)
                }
            }
        }
    }
    
//    override func loadView() {
//        super.loadView()
//        self.navigationController?.navigationBar.isHidden = true
//    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
   
    fileprivate func buildUI() {
        weak var weakSelf = self
        mineHeadView = MineHeadView.init(frame: CGRect.init(x: 0, y: 0, width: Int(ScreenWidth), height: headViewHeight), mineHeadViewClickBlockBack: {
            let settingVc = SettingViewController()
            weakSelf?.navigationController?.pushViewController(settingVc, animated: true)
        })
        view.addSubview(mineHeadView)
        buildTableUI()
    }
    
    fileprivate func buildTableUI() {
        tableView = BaseTableView.init(frame: CGRect.init(x: 0, y: headViewHeight, width: Int(ScreenWidth), height: Int(ScreenHeight) - headViewHeight), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 10.0
        tableView.sectionFooterHeight = 0.00001
        view.addSubview(tableView)
        
        weak var weakSelf = self
        tableHeadView = MineTableHeadView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 70))
        tableHeadView?.mineTableHeadViewBlock = {
            (_ type: MineHeadViewButtonType) -> () in
            switch type {
            case .order:
                weakSelf!.navigationController?.pushViewController(OrderViewController(), animated: true)
                break
            case .coupon:
                weakSelf!.navigationController?.pushViewController(OrderViewController(), animated: true)
                break
            case .message:
                weakSelf!.navigationController?.pushViewController(OrderViewController(), animated: true)
                break
//            default:
//                break
            }
        }
        tableView.tableHeaderView = tableHeadView
    }
    
}

extension MineVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 0 == section {
            return 2
        } else if (1 == section) {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if 0 == indexPath.section {
            
        }else if 1 == indexPath.section {
            
        }else if 2 == indexPath.section {
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MineCell.cellFor(tableView: tableView)
        if 0 == indexPath.section {
            cell.mineModel = mineModel[indexPath.row]
        }else if 1 == indexPath.section {
            cell.mineModel = mineModel[2]
        }else {
            if indexPath.row == 0 {
                cell.mineModel = mineModel[3]
            }else {
                cell.mineModel = mineModel[4]
            }
        }
        return cell
    }
    
}
