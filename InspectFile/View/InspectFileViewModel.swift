//
//  InspectFileViewModel.swift
//  InspectFile
//
//  Created by Andrey Chernoprudov on 17/06/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

import FileinspectorCore

class InspectFileViewModel {
    
    // MARK: - Insance variables
    
    var attributes: [FileAttribute] = []
    
    let interactor: InspectFileInteractor
    let context: NSExtensionContext
    
    weak var view: InspectFileView?
    
    // MARK: - Public
    
    init(context: NSExtensionContext, interactor: InspectFileInteractor) {
        self.context = context
        self.interactor = interactor
    }
    
    func start() {
        interactor.inspect(context) { [weak self] attributes in
            self?.successFetch(attributes)
        }
    }
    
    // MARK: - Private
    
    func successFetch(_ attributes: [FileAttribute]) {
        DispatchQueue.main.async {
            self.attributes = attributes
            self.view?.updateData()
        }
    }
}
