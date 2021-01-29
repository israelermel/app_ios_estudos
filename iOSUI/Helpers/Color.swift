//
//  Color.swift
//  iOSUI
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import UIKit

struct Color {
    static let primary = UIColor(hex: "#880E4F")
    static let primaryDark = UIColor(hex: "#560027")
    static let primaryLight = UIColor(hex: "#BC477B")
    static let primaryTextLight = UIColor(hex: "#B8B8B8")
    static let primaryTextDark = UIColor(hex: "#383838")
    static let primaryAction = UIColor(hex: "#FF7401")
    static let infoAction = UIColor(hex: "#007AFF")
    static let primaryActionDisable = UIColor(hex: "#FF7401").withAlphaComponent(0.67)
}
