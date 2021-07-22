//
//  PandoraTableViewController.swift
//  Pandora
//
//  Created by 申铭 on 2021/3/22.
//

import UIKit

let kSubscribeEmailNotification = "订阅邮箱通知"
let kSubscribedEmailNotification = "已订阅邮箱通知人员"
let kWebUploader = "上传文件至手机"

class PandoraTableViewController: UITableViewController {
    
    private var operations = Array<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        operations.append(kWebUploader)
        operations.append(kSubscribeEmailNotification)
        operations.append(kSubscribedEmailNotification)

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
        
        if operations[indexPath.row] == kSubscribeEmailNotification {
            let vc = SubscribeEmailNotificationController.loadFromStoryboard(name: "Main", identifier: "openEmailNotification")
            navigationController?.pushViewController(vc, animated: true)
        } else if operations[indexPath.row] ==  kSubscribedEmailNotification {
            navigationController?.pushViewController(SubscribedEmailNotificationController(), animated: true)
        } else if operations[indexPath.row] ==  kWebUploader {
            let vc = WebUploaderController.loadFromStoryboard(name: "Main", identifier: "webUploader")
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
