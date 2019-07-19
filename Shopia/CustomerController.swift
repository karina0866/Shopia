//
//  CustomerController.swift
//  Shopia
//
//  Created by karina lia meirita ulo on 14/07/19.
//  Copyright © 2019 karina lia meirita ulo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import GoogleSignIn

class CustomerController : UIViewController,GIDSignInUIDelegate {
    let btnLogout =  UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.addSubview(btnLogout)
        setupLogoutButton()
        
    }
    
    func setupLogoutButton(){
        btnLogout.setTitle("Logout", for: .normal)
        btnLogout.backgroundColor = UIColor(red: 252/256, green: 175/256, blue: 69/256, alpha: 1)
        btnLogout.layer.cornerRadius = 7
        btnLogout.setTitleColor(.white, for: .normal)
        btnLogout.translatesAutoresizingMaskIntoConstraints = false
        btnLogout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        btnLogout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        btnLogout.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnLogout.topAnchor.constraint(equalTo:view.topAnchor, constant: 100).isActive = true
        
        btnLogout.addTarget(self, action: #selector(btnLogoutTapped), for: .touchUpInside)
    }
    @objc func btnLogoutTapped(){
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
            do{
                try Auth.auth().signOut()
                GIDSignIn.sharedInstance().signOut()
                let loginController = LoginController()
             //   let loginNavigationController = UINavigationController(rootViewController: loginController)
                self.present(loginController, animated: true,completion: nil)
            }catch let err{
                print("failed to sign out with error",err)
                Service.showAlert(on: self, style: .alert, title: "Sign Out Error", message: err.localizedDescription)
                
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        Service.showAlert(on: self, style: .actionSheet, title: nil, message: nil, actions: [signOutAction,cancelAction], completion: nil)
    }
    
}
