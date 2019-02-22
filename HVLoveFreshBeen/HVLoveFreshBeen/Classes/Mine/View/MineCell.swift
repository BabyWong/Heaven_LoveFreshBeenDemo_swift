//
//  MineCell.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 1/10/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

class MineCell: UITableViewCell {
    
    fileprivate var titleLable: UILabel = UILabel()
    fileprivate var iconImageView: UIImageView = UIImageView()
    fileprivate var arrowView: UIImageView = UIImageView()
    fileprivate let bottomLine = UIView()
    static fileprivate let identifierStr = "mineCellID"
    var mineModel: MineCellModel? {
        didSet {
            titleLable.text = mineModel?.title
            iconImageView.image = UIImage.init(named: mineModel!.iconName!)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconImageView)
        titleLable.textColor = UIColor.black
        titleLable.font = UIFont.systemFont(ofSize: 16)
        titleLable.alpha = 0.8
        contentView.addSubview(titleLable)
        
        bottomLine.backgroundColor = UIColor.gray
        bottomLine.alpha = 0.15
        contentView.addSubview(bottomLine)
        
        arrowView.image = UIImage(named: "icon_go")
        contentView.addSubview(arrowView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        arrowView.frame = CGRect.init(x: mj_w - 20, y: (mj_h - ((arrowView.image?.size.height)!)) * 0.5, width: (arrowView.image?.size.width)!, height: (arrowView.image?.size.height)!)
        
        let rightMargin: CGFloat = 10
        let iconWH: CGFloat = 20
        iconImageView.frame = CGRect(x: rightMargin, y: (mj_h - iconWH) * 0.5, width: iconWH, height: iconWH)
        titleLable.frame = CGRect(x: iconImageView.frame.maxX + rightMargin, y: 0, width: 200, height: mj_h)
        
        let leftMarge: CGFloat = 20
        bottomLine.frame = CGRect(x: leftMarge, y: mj_h - 0.5, width: mj_w - leftMarge, height: 0.5)
    }
    
    class func cellFor(tableView: UITableView) -> MineCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifierStr) as? MineCell
        if cell == nil {
            cell = MineCell.init(style: .default, reuseIdentifier: identifierStr)
        }
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


class MineCellModel: NSObject {
    @objc var title: String?
    @objc var iconName: String?
    
    class func loadMineCellModel() -> [MineCellModel] {
        var mines = [MineCellModel]()
        let path = Bundle.main.path(forResource: "MinePlist", ofType: "plist")
//        let arr = NSArray.init(contentsOfFile: path!)
        mines = MineCellModel.mj_objectArray(withFile: path) as! [MineCellModel]
        return mines
    }
}
