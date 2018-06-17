//
//  InspectFileView.swift
//  InspectFile
//
//  Created by Andrey Chernoprudov on 17/06/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

protocol InspectFileView: class {
    
    func updateData()
    
    func showAlert(title: String, message: String)

}
