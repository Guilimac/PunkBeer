//
//  BeerViewController.swift
//  PunkBeer
//
//  Created by gui on 14/07/17.
//  Copyright © 2017 fiap. All rights reserved.
//

import UIKit

class BeerViewController: UIViewController {

    var beer : ModelBeer!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var description_text: UITextView!
    @IBOutlet weak var abv: UILabel!
    @IBOutlet weak var ibu: UILabel!
    @IBOutlet weak var imagem: UIImageView!
    
    func initialize(beer : ModelBeer) {
        self.beer = beer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = beer.name
        tagline.text = beer.tagline
        description_text.text = beer.description
        abv.text = "\(beer.abv!)"
        ibu.text = "\(beer.ibu)"
        
        DispatchQueue.global().async {
            if let image = URL(string: self.beer.image_url) {
                URLSession.shared.dataTask(with: image, completionHandler: { (data : Data?, response : URLResponse?, error : Error?) in
                    if error == nil && data != nil {
                        DispatchQueue.main.async {
                            if let image = data as? Data {
                                self.imagem.image = UIImage.init(data: image)
                            }
                        }
                    }
                }).resume()
            } else {
                print(self.beer.image_url)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // remove label do botão
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .done, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
