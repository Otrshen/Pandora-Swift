import UIKit

protocol NibProtocol {
    
}

extension NibProtocol {
    static func loadFromNib() -> Self {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.first as! Self
    }
    
    static func loadFromStoryboard(name: String, identifier: String) -> Self{
        return UIStoryboard.init(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier) as! Self 
    }
}
