//
//  DialRecord.swift
//  PrjThreeDTouchQuickDial
//
//  Created by TzuHuan Shao on 2019/5/2.
//  Copyright © 2019 TzuHuan Shao. All rights reserved.
//

import Foundation

struct FileObject: Codable {
    let name: String
    let type: String
    let url:  URL
}

extension FileObject: Equatable {
    
    static func==(lhs: FileObject, rhs: FileObject) -> Bool {
        return    (lhs.name  == rhs.name)
               && (lhs.type == rhs.type)
//               && (lhs.url  == rhs.url)
    }
}
