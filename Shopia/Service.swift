//
//  Service.swift
//  Shopia
//
//  Created by karina lia meirita ulo on 14/07/19.
//  Copyright © 2019 karina lia meirita ulo. All rights reserved.
//

import Foundation
import UIKit

class Service{
   // static var baseColor = UIColor(r: 264, g: 202, b: 64)
    static var baseColor = UIColor(red: 265, green: 202, blue: 64, alpha: 1)
    static var darkColor = UIColor(red: 253, green: 166, blue: 47, alpha: 1)
    static var unselectedItemColor = UIColor(red:173, green: 173, blue: 173, alpha: 1)
   // static var un = UIColor(
    
    static func showAlert(on:UIViewController, style: UIAlertController.Style, title:String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "Ok", style: .default, handler: nil)], completion: (()-> Swift.Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions{
            alert.addAction(action)
        }
        on.present(alert, animated: true, completion: nil)
    }
}
