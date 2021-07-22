//
//  WebUploaderController.swift
//  Pandora
//
//  Created by 申铭 on 2021/7/20.
//

import UIKit
import GCDWebServer

class WebUploaderController: UIViewController, NibProtocol {
    
    private var uploader: GCDWebUploader?

    @IBOutlet weak var serverUrlLabel: UILabel!
    @IBOutlet weak var savePathLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSHomeDirectory() + "/Documents/UploaderFiles"
        FileUtil.createFolder(path: path)
        
        uploader = GCDWebUploader(uploadDirectory: path)
        uploader?.start(withPort: 8080, bonjourName: "潘多拉文件管理")
        
        self.serverUrlLabel.text = "请在浏览器中访问此URL：\(uploader?.serverURL?.absoluteString ?? "服务启动失败")"
        self.savePathLabel.text = "文件保存路径：\(path)"
        print(uploader?.serverURL ?? "无")
        print(path)
    }
    
    deinit {
        uploader?.stop()
    }
        
}
