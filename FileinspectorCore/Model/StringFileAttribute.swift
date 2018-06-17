//
//  StringFileAttribute.swift
//  FileinspectorCore
//
//  Created by Andrey Chernoprudov on 17/06/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

public struct StringFileAttribute: FileAttribute {
    
    public let type: FileAttributeType = .string
    
    public let title: String
    public let value: String
}

public struct AttributedStringFileAttribute: FileAttribute {
    
    public let type: FileAttributeType = .attributedString
    
    public let title: String
    public let value: NSAttributedString
}

