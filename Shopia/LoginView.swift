//
//  LoginView.swift
//  Shopia
//
//  Created by karina lia meirita ulo on 14/07/19.
//  Copyright © 2019 karina lia meirita ulo. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    func setup(){
       backgroundColor = .red
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
