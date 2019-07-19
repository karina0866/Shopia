//
//  HomeViewController.swift
//  Shopia
//
//  Created by karina lia meirita ulo on 19/07/19.
//  Copyright © 2019 karina lia meirita ulo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        fetchData()
      // var eComm = [Response]()

        // Do any additional setup after loading the view.
    }
    

    func fetchData()
    {
        let jsonUrlString = "https://private-4639ce-ecommerce56.apiary-mock.com/home"
        guard  let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            
            do{
                let responses = try JSONDecoder().decode([Response].self, from: data)
             
                print(responses)
            }catch let jsonError{
                print(jsonError)
            }
            }.resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
