//
//  InspectFileViewModel.swift
//  InspectFile
//
//  Created by Andrey Chernoprudov on 17/06/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

import FileinspectorCore
//import FileinspectorCore

class InspectFileViewModel {
    
    var attributes: [FileAttribute] = []
    
    let interactor: InspectFileInteractor
    
    init(interactor: InspectFileInteractor) {
        self.interactor = interactor
    }

}
