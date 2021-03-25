//
//  SubscribeEmailNotificationController.swift
//  Pandora
//
//  Created by 申铭 on 2021/3/22.
//

import UIKit

class SubscribeEmailNotificationController: UIViewController, NibProtocol {

    @IBOutlet weak var emailTextField: UITextField!
    private var viewModel: SubscribeEmailNotificationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = SubscribeEmailNotificationViewModel();
        
        title = "开启通知"
        view.backgroundColor = .white
    }
    
    @IBAction func submit(_ sender: Any) {
        viewModel.subscribeEmailNotification(email: emailTextField.text ?? "")
    }
    
}
