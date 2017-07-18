//
//  ModelBeer.swift
//  PunkBeer
//
//  Created by gui on 14/07/17.
//  Copyright © 2017 fiap. All rights reserved.
//

import Foundation

class ModelBeer {
    
    var image_url : String!
    var name : String!
    var abv : Double!
    var tagline : String!
    var ibu : Int = 0
    var description : String!

    init(data : [String : Any]) {
        
        self.name = data["name"]! as? String ?? ""
        self.description = data["description"]! as? String ?? ""
        self.tagline = data["tagline"]! as? String ?? ""
        self.image_url = data["image_url"]! as? String ?? ""
        
        self.ibu = data["ibu"]! as? Int ?? 0
        self.abv = data["abv"]! as? Double ?? 0.0
        
//        self.image_url = data["tagline"]! as? String ?? ""
    }
    
}
