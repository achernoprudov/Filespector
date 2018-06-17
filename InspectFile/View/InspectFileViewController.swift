//
//  InspectFileViewController.swift
//  InspectFile
//
//  Created by Andrey Chernoprudov on 17/06/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

import UIKit

class InspectFileViewController: UIViewController, InspectFileView {
    
    // MARK: - Insance variable
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: InspectFileViewModel?
    
    // MARK: - Public
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDependencies()
        
        viewModel?.start()
    }
    
    func updateData() {
        tableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @IBAction func closeController(_ sender: Any) {
        extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    // MARK: - Private
    
    func setupDependencies() {
        let assembler = InspectFileAssembler(extensionContext: extensionContext!)
        viewModel = assembler.buildModel(for: self)
    }
}
