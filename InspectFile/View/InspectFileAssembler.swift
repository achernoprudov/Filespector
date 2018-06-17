//
//  InspectFileAssembler.swift
//  InspectFile
//
//  Created by Andrey Chernoprudov on 17/06/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

import Foundation
import FileinspectorCore

struct InspectFileAssembler {
    
    let extensionContext: NSExtensionContext
    
    func buildModel(for view: InspectFileView) -> InspectFileViewModel {
        let interactor = InspectFileInteractor()
        let model =  InspectFileViewModel(
            context: extensionContext,
            interactor: interactor)
        model.view = view
        return model
    }

}
