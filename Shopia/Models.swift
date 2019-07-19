//
//  Models.swift
//  Shopia
//
//  Created by karina lia meirita ulo on 19/07/19.
//  Copyright © 2019 karina lia meirita ulo. All rights reserved.
//

import Foundation
struct Response:Codable{
        let data : [Data]
    }
    struct Data:Codable{
        let category: [Category]
        let productPromo : [ProductPromo]
    }

    struct Category:Codable {
        let imageUrl :String?
        let id: Int?
        let name: String?

    }

    struct ProductPromo:Codable {
        let id: String?
        let imageUrl: String?
        let title:String?
        let description : String?
        let price : String?
        let loved : Bool?

    }
