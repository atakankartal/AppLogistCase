//
//  Double+Extensions.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import Foundation
import UIKit

extension Double {
    var scale: CGFloat {
        return UIWindow().frame.width * CGFloat(self) / 414
    }
}

