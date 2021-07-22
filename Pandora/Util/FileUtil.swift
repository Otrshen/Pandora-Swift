//
//  FileUtil.swift
//  Pandora
//
//  Created by 申铭 on 2021/7/21.
//

class FileUtil {
    
    /// 创建文件夹
    /// - Parameter path: 文件夹路径
    /// - Returns: 结果
    @discardableResult
    static func createFolder(path: String) -> Bool {
        let manager = FileManager.default
        let exist = manager.fileExists(atPath: path)
        
        if exist { return true }
        
        do{
            try manager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            print("创建文件夹成功")
            return true
        }
        catch{
            print("创建文件夹失败")
            return false
        }
    }
}
