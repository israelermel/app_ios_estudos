//
//  VNDivider.swift
//  iOSUI
//
//  Created by Israel Ermel on 10/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit

class VNDivider: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        label.text = "Ou"
        label.textColor = Color.primaryTextDark
        label.font = UIFont.systemFont(ofSize: 14)
        
        addSubview(label)
        label.centerX(inView: self)
        label.centerY(inView: self)
        
        let divider1 = UIView()
        divider1.backgroundColor = Color.primaryTextLight
        addSubview(divider1)
        divider1.centerY(inView: self)
        divider1.anchor(left: leftAnchor, right: label.leftAnchor,
                        paddingLeft: 8,paddingRight: 8, height: 1.0)
        
        let divider2 = UIView()
        divider2.backgroundColor = Color.primaryTextLight
        addSubview(divider2)
        divider2.centerY(inView: self)
        divider2.anchor(left: label.rightAnchor, right: rightAnchor,
                        paddingLeft: 8,paddingRight: 8, height: 1.0)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
