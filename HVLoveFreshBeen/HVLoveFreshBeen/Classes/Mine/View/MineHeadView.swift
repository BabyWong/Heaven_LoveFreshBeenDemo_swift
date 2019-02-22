//
//  MineHeadView.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/11/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

class MineHeadView: UIImageView {

    fileprivate let iconView = IconView()
    var mineHeadViewClickBlock: (() -> Void)?
    let setUpBtn: UIButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        image = UIImage.init(named: "v2_my_avatar_bg")
        setUpBtn.setImage(UIImage.init(named: "v2_my_settings_icon"), for: .normal)
        setUpBtn.addTarget(self, action: #selector(clickSettingBtn), for: .touchUpInside)
        addSubview(setUpBtn)
        addSubview(iconView)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let iconViewWH: CGFloat = 150
        iconView.frame = CGRect(x: (mj_w - 150) * 0.5, y: 35.0 / 150.0 * self.frame.size.height, width: iconViewWH, height: iconViewWH)
        setUpBtn.frame = CGRect(x: mj_w - 50, y: 25.0 / 150.0 * self.frame.size.height, width: 50, height: 50)
    }
    
    @objc func clickSettingBtn() {
        mineHeadViewClickBlock?()
    }
    
    convenience init(frame: CGRect, mineHeadViewClickBlockBack:@escaping (() -> Void)) {
        self.init(frame: frame)
        mineHeadViewClickBlock = mineHeadViewClickBlockBack
    }
    
}

class IconView: UIView {
    
    fileprivate var iconImageView = UIImageView.init(image: UIImage.init(named: "v2_my_avatar"))
    fileprivate let phoneLable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconImageView = UIImageView(image: UIImage(named: "v2_my_avatar"))
        addSubview(iconImageView)
        
        phoneLable.text = "18612348765"
        phoneLable.font = UIFont.systemFont(ofSize: 18)
        phoneLable.textColor = .white
        phoneLable.textAlignment = .center
        addSubview(phoneLable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.frame = CGRect(x: (mj_w - iconImageView.mj_size.width) * 0.5, y: 0, width: iconImageView.mj_size.width, height: iconImageView.mj_size.height)
        phoneLable.frame = CGRect(x: 0, y: iconImageView.frame.maxY + 5, width: mj_w, height: 30)
    }
}
