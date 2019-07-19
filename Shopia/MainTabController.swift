//
//  MainTabController.swift
//  Shopia
//
//  Created by karina lia meirita ulo on 14/07/19.
//  Copyright © 2019 karina lia meirita ulo. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth


class MainTabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLoggedInStatus()
        setupViewController()
    }
    
    
    fileprivate func setupViewController(){
        tabBar.unselectedItemTintColor = Service.unselectedItemColor
        tabBar.tintColor = Service.darkColor
        
        let homeController = HomeViewController()
        let homeNavigationController = UINavigationController(rootViewController: homeController)
        homeNavigationController.tabBarItem.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        homeNavigationController.tabBarItem.selectedImage=UIImage(named:"home")?.withRenderingMode(.alwaysTemplate)
        
        let historyController = HistoryController()
        let historyNavigationController = UINavigationController(rootViewController: historyController)
        historyNavigationController.tabBarItem.image = UIImage(named:"history")?.withRenderingMode(.alwaysTemplate)
        historyNavigationController.tabBarItem.selectedImage = UIImage(named:"history-filled")?.withRenderingMode(.alwaysTemplate)
        
        
        let customerController = CustomerController()
        let customerNavigationController = UINavigationController(rootViewController: customerController)
        customerNavigationController.tabBarItem.image = UIImage(named:"signout")?.withRenderingMode(.alwaysTemplate)
            customerNavigationController.tabBarItem.selectedImage = UIImage(named:"signout")?.withRenderingMode(.alwaysTemplate)
        viewControllers = [homeNavigationController,historyNavigationController,customerNavigationController]
        
        guard let items = tabBar.items else {return}
        for item in items{
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    
    fileprivate func checkLoggedInStatus(){
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let loginController = LoginController()
           //     let loginNavigationController = UINavigationController(rootViewController: loginController)
                self.present(loginController, animated: false, completion: nil)
                return
            }
        }
    }
    
}
