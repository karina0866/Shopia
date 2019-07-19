//
//  LoginController.swift
//  Shopia
//
//  Created by karina lia meirita ulo on 14/07/19.
//  Copyright © 2019 karina lia meirita ulo. All rights reserved.
//

import Foundation
import UIKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import FirebaseAuth
import GoogleSignIn

class LoginController:UIViewController, GIDSignInUIDelegate{

    let lblShopia = UILabel()
    let txtUsername = UITextField()
    let txtPassword = UITextField()
    let btnLogin = UIButton()
    let btnFacebook = UIButton()
    let btnGoogle = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
     //   GIDSignIn.sharedInstance()?.signIn()
        setupViewController()
      //  GIDSignIn.sharedInstance()?.uiDelegate = self as! GIDSignInUIDelegate
        
        
    }
    
    func setupViewController(){
        view.backgroundColor = .white
        
        view.addSubview(lblShopia)
        setupLblShopia()
        view.addSubview(txtUsername)
        setupTxtUsername()
        
        view.addSubview(txtPassword)
        setupTxtPassword()
        
        view.addSubview(btnLogin)
        setupLoginButton()
        
        view.addSubview(btnFacebook)
        setupFacebookButton()
        
        view.addSubview(btnGoogle)
        setupGoogleButton()
    }
    
    func setupLblShopia(){
        lblShopia.textAlignment = .center
        lblShopia.frame = CGRect(x:0 , y:150, width: view.frame.width, height: 100)
        lblShopia.text = "Shopia"
        lblShopia.font = UIFont(name: "Futura", size:80.0)
        lblShopia.textColor = .black
        lblShopia.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120)
       
        
    }
    
    func setupTxtUsername(){
        txtUsername.placeholder = "Username or Email"
        txtUsername.font = UIFont.init(name: "System", size: 16.0)
        txtUsername.borderStyle = .roundedRect
        txtUsername.translatesAutoresizingMaskIntoConstraints = false
        txtUsername.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        txtUsername.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        txtUsername.heightAnchor.constraint(equalToConstant: 40).isActive = true
        txtUsername.topAnchor.constraint(equalTo: lblShopia.bottomAnchor,constant: 50).isActive = true
    }
    
    func setupTxtPassword(){
         txtPassword.placeholder = "Password"
         txtPassword.font = UIFont.init(name: "System", size: 16.0)
         txtPassword.isSecureTextEntry = true
         txtPassword.borderStyle = .roundedRect
         txtPassword.translatesAutoresizingMaskIntoConstraints = false
         txtPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
         txtPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
         txtPassword.heightAnchor.constraint(equalToConstant: 40).isActive = true
         txtPassword.topAnchor.constraint(equalTo: txtUsername.bottomAnchor,constant: 10).isActive = true
    }
    
    func setupLoginButton(){
        
        btnLogin.setTitle("Login", for: .normal)
        btnLogin.backgroundColor = UIColor(red: 252/256, green: 175/256, blue: 69/256, alpha: 1)
        btnLogin.layer.cornerRadius = 7
        btnLogin.setTitleColor(.white, for: .normal)
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        btnLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        btnLogin.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnLogin.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 20).isActive = true
    }
    
    func setupFacebookButton(){
        btnFacebook.setTitle("Login with Facebook", for: .normal)
        btnFacebook.backgroundColor = UIColor(red: 60/256, green: 90/256, blue: 153/256, alpha: 1)
        btnFacebook.layer.cornerRadius = 7
        btnFacebook.setTitleColor(.white, for: .normal)
        btnFacebook.translatesAutoresizingMaskIntoConstraints = false
        btnFacebook.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        btnFacebook.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        btnFacebook.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnFacebook.topAnchor.constraint(equalTo: btnLogin.bottomAnchor, constant: 20).isActive = true
        
        btnFacebook.addTarget(self, action: #selector(facebookLoginButtonTapped), for: .touchUpInside)
    }
    
    func setupGoogleButton()    {
        
        GIDSignIn.sharedInstance().uiDelegate = self
        btnGoogle.setTitle("Login with Google", for: .normal)
        btnGoogle.backgroundColor = UIColor(red: 219/256, green: 68/256, blue: 55/256, alpha: 1)
        btnGoogle.layer.cornerRadius = 7
        btnGoogle.translatesAutoresizingMaskIntoConstraints = false
        btnGoogle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        btnGoogle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        btnGoogle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnGoogle.topAnchor.constraint(equalTo: btnFacebook.bottomAnchor, constant: 20).isActive = true
        
        btnGoogle.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
    }
   @objc func  handleGoogleSignIn(){
    GIDSignIn.sharedInstance()?.signIn()
    DispatchQueue.main.async {
        let homeScreen = MainTabBarController()

        self.present(homeScreen, animated: false, completion: nil)
        return
    }
    }
    @objc func facebookLoginButtonTapped(){
        
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.email,.publicProfile], viewController: self) { (result) in
            switch result{
            case .success(granted: _, declined: _, token: _):
                print("suceesfullt logged in into Facebook")
                self.signIntoFirebase()
                
            case .failed(let err):
                print(err.localizedDescription)
      
            case .cancelled:
                print("cancelled login via facebook")
         
            }
        }
    }
    @objc func signIntoFirebase(){
        guard let authenticationToken = AccessToken.current?.tokenString else {return}
        let credential = FacebookAuthProvider.credential(withAccessToken: authenticationToken)
        Auth.auth().signIn(with: credential) { (user, err) in
            if let err = err {
               print(err.localizedDescription)
                return
            }
            print("Succesfully authenticated with Firebase.")
            DispatchQueue.main.async {
                let homeScreen = MainTabBarController()
            
                self.present(homeScreen, animated: false, completion: nil)
                return
            }
        }
   
    }

    

}

