//
//  StringExtension.swift
//  Homekeeper
//
//  Created by Tanner Strom on 10/13/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import Foundation

extension String {
    static func className(aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).componentsSeparatedByString(".").last!
    }
}