//
//  SubscribedEmailNotificationController.swift
//  Pandora
//
//  Created by 申铭 on 2021/3/25.
//
//  已订阅人员

import UIKit

class SubscribedEmailNotificationController: UITableViewController {
    
    private var emailArr = Array<Email>()
    
    private let viewModel = SubscribedEmailNotificationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.queryAllSubscribedEmail { [self] (emails) in
            emailArr = emails
            tableView.reloadData()
        }
        
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SubscribedEmailCell")
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscribedEmailCell", for: indexPath)
        cell.textLabel?.text = emailArr[indexPath.row].email
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
