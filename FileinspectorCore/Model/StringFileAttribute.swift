//
//  StringFileAttribute.swift
//  FileinspectorCore
//
//  Created by Andrey Chernoprudov on 17/06/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

struct StringFileAttribute: FileAttribute {
    
    var type: FileAttributeType = .string
    
    let title: String
    let value: String
    
}
