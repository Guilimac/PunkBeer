//
//  TableViewCell.swift
//  PunkBeer
//
//  Created by gui on 15/07/17.
//  Copyright © 2017 fiap. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var abv: UILabel!
    @IBOutlet weak var photo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadImage(image : URL) {
        
        DispatchQueue.global().async {
        
            URLSession.shared.dataTask(with: image, completionHandler: { (data : Data?, response : URLResponse?, error : Error?) in
                
                if error == nil && data != nil {
                    
                    DispatchQueue.main.async {
                        if let image = data {
                            self.photo.image = UIImage.init(data: image)
                        }
                    }
                }
            }).resume()
        }
    }
}
