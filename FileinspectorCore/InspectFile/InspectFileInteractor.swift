//
//  InspectFileInteractor.swift
//  FileinspectorCore
//
//  Created by Andrey Chernoprudov on 17/06/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

import Foundation

public struct InspectFileInteractor {
    
    public init() {
    }

    
    public func inspect(_ context: NSExtensionContext, completition: ([FileAttribute]) -> Void) {
        let attribute = StringFileAttribute(title: "foo", value: "bar")
        completition([attribute])
    }
}
