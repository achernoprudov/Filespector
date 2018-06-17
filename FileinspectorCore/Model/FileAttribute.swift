//
//  FileAttribute.swift
//  FileinspectorCore
//
//  Created by Andrey Chernoprudov on 17/06/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

enum FileAttributeType {
    case string
}

protocol FileAttribute {
    var title: String { get }
    var type: FileAttributeType { get }
}
