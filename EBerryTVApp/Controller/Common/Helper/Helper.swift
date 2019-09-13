//
//  Helper.swift
//  EBerryTVApp
//
//  Created by Mehmet Can Seyhan on 2019-09-13.
//  Copyright © 2019 Mehmet Can Seyhan. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    //MARK: CONSTRAINTS
    static let replaceableArray:[String] = ["<p>","</p>","<b>","</b>"]
    
    //MARK: FUNCTIONS
    //Show dialog box
    static func dialogMessage(message:String, vc:UIViewController) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    //Load image data from server
    static func imageLoad(imageView:UIImageView, url:String) {
        let downloadTask = URLSession.shared.dataTask(with: URL(string: url)!) { (data, urlResponse, error) in
            if error == nil && data != nil {
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
        downloadTask.resume()
    }
    
    //Remove characters which aren't normal
    static func replaceContent(text: String?) -> String {
        var replacedText:String = ""
        if let incomingText = text {
            replacedText  = incomingText
            for i in 0..<replaceableArray.count {
                replacedText = replacedText.replacingOccurrences(of: replaceableArray[i], with: "")
            }
        }
        return replacedText
    }
}
