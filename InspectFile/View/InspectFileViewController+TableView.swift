//
//  InspectFileViewController+TableView.swift
//  InspectFile
//
//  Created by Andrey Chernoprudov on 17/06/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

import UIKit
import FileinspectorCore

extension InspectFileViewController: UITableViewDataSource {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    var attributes: [FileAttribute] {
        return viewModel?.attributes ?? []
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO optimize by identifier
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.update(with: attributes[indexPath.row])
        return cell
    }
}

extension UITableViewCell {
    
    func update(with attribute: FileAttribute) {
        detailTextLabel?.text = attribute.title
        switch attribute {
        case let stringAttribute as StringFileAttribute:
            textLabel?.text = stringAttribute.value
        case let strAttributed as AttributedStringFileAttribute:
            textLabel?.attributedText = strAttributed.value
        default:
            textLabel?.text = "Cant bind attribute: \(attribute)"
        }
    }
}
