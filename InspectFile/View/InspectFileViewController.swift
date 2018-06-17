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
        navigationController?.view.isHidden = true
        setupTableView()
        setupDependencies()
        
        viewModel?.start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateAppearing()
    }
    
    func updateData() {
        tableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @IBAction func closeController(_ sender: Any) {
        let height = navigationController!.view.frame.size.height
        
        UIView.animate(withDuration: 0.2, animations: {
            self.navigationController!.view.transform
                = CGAffineTransform(translationX: 0, y: height)
        }, completion: { _ in
            self.extensionContext!.completeRequest(
                returningItems: [],
                completionHandler: nil)
        })
    }
    
    // MARK: - Private
    
    private func setupDependencies() {
        let assembler = InspectFileAssembler(extensionContext: extensionContext!)
        viewModel = assembler.buildModel(for: self)
    }
    
    private func animateAppearing() {
        let view = navigationController!.view!
        view.isHidden = false
        view.transform = CGAffineTransform(translationX: 0, y: view.frame.size.height)
        UIView.animate(withDuration: 0.25) {
            view.transform = .identity
        }
    }
}
