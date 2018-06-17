//
//  InspectFileViewController.swift
//  InspectFile
//
//  Created by Andrey Chernoprudov on 17/06/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

import UIKit

class InspectFileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext.
        
    }

    @IBAction func closeController(_ sender: Any) {
        extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
}
