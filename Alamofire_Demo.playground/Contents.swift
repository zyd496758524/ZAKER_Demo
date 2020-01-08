import UIKit

func escape(string: String) -> String {
    let generalDelimitersToEncode = ":#[]@"
    
    let subDelimitersToEncode = "!$&'()*+,;="
    
    let allowedCharacterSet = NSCharacterSet.URLQueryAllowedCharacterSet.mutableCopy() as! NSMutableCharacterSet
    
    
}
