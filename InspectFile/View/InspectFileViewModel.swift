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
        interactor.inspect(context) { [weak self] result in
            switch result {
            case .success(let attributes):  self?.successFetch(attributes)
            case .error(let error): 	    self?.fail(with: error)
            }
        }
    }
    
    // MARK: - Private
    
    func successFetch(_ attributes: [FileAttribute]) {
        DispatchQueue.main.async {
            self.attributes = attributes
            self.view?.updateData()
        }
    }
    
    func fail(with error: Error) {
        print(error.localizedDescription)
        view?.showAlert(title: "Error", message: error.localizedDescription)
    }
}
