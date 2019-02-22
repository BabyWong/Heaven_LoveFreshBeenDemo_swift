//
//  IconImageTextView.swift
//  HVLoveFreshBeen
//
//  Created by Heaven on 2/22/19.
//  Copyright © 2019 cenntro. All rights reserved.
//

import UIKit

class IconImageTextView: UIView {
    
    fileprivate var imageView: UIImageView?
    fileprivate var textLabel: UILabel?
    fileprivate var placeholderImage: UIImage?
    
    var activitie: Activities? {
        didSet {
            textLabel?.text = activitie?.name
            imageView?.sd_setImage(with: URL(string: activitie!.img!)!, placeholderImage: placeholderImage)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView?.isUserInteractionEnabled = false
        //        imageView?.contentMode = UIView.ContentMode.center
        addSubview(imageView!)
        
        textLabel = UILabel()
        textLabel!.textAlignment = NSTextAlignment.center
        textLabel!.font = UIFont.systemFont(ofSize: 12)
        textLabel!.textColor = UIColor.black
        textLabel?.isUserInteractionEnabled = false
        addSubview(textLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, placeholderImage: UIImage) {
        self.init(frame: frame)
        self.placeholderImage = placeholderImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = CGRect(x: 10, y: 5, width: width - 20, height:  width - 50)
        textLabel?.frame = CGRect(x: (width - imageView!.width) / 2.0, y: height - 25, width: imageView!.width, height: 20)
    }
}
