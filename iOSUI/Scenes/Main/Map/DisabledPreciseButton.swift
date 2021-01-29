//
//  DisabledPreciseButton.swift
//  iOSUI
//
//  Created by Israel Ermel on 10/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit

public class DisabledPreciseButton: UIButton {
    
    public init(title: String) {
        super.init(frame: .zero)

        config(title: title)
    }
    
    private let buttonWidth: CGFloat = 30
    
    let iconRight: UIImage = #imageLiteral(resourceName: "info_chevron").withRenderingMode(.alwaysOriginal)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(title: String) {
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        setHeight(height: buttonWidth)
        setWidth(width: 180)
        backgroundColor = Color.infoAction
        setTitleColor(.white, for: .normal)
        titleLabel?.adjustsFontSizeToFitWidth = true
        layer.cornerRadius = buttonWidth / 2
        setImage(iconRight, for: .normal)
        semanticContentAttribute = .forceRightToLeft
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 10)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        self.setWidthGreaterOrEqual(width: 180)

    }
    
    
}
