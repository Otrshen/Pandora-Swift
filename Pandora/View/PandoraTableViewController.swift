//
//  PandoraTableViewController.swift
//  Pandora
//
//  Created by 申铭 on 2021/3/22.
//

import UIKit

let kOpenEmailNotification = "开启邮箱通知"

class PandoraTableViewController: UITableViewController {
    
    private var operations = Array<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        operations.append(kOpenEmailNotification)

        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PandoraCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PandoraCell", for: indexPath)
        cell.textLabel?.text = operations[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if operations[indexPath.row] == kOpenEmailNotification {
            let vc = SubscribeEmailNotificationController.loadFromStoryboard(name: "Main", identifier: "openEmailNotification")
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
