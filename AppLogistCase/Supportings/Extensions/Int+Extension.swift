//
//  Int+Extension.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import Foundation
import UIKit

extension Int {

    var scale: CGFloat {
        return UIWindow().frame.width * CGFloat(self) / 414
    }
}
