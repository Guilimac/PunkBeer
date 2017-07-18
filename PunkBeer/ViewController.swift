//
//  ViewController.swift
//  PunkBeer
//
//  Created by gui on 14/07/17.
//  Copyright © 2017 fiap. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let apiUrl = URL(string: "https://api.punkapi.com/v2/beers")!
    var dataSource : [ModelBeer]!
    var label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // inicializa datasource
        dataSource = []

        label.text = "Carregando..."
        label.textAlignment = .center
        label.tintColor = UIColor.gray
        tableView.backgroundView = label
        
        // carrega dados da api
        // URLSession.shared.downloadTask(with: )
        URLSession.shared.dataTask(with: apiUrl) { (data : Data?, response : URLResponse?, error : Error?) in
            
            if data == nil || error != nil {
                self.label.text = "Erro ao carregar dados"
                self.tableView.backgroundView = self.label
            }
            
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            
            if json != nil {
               
                if let list = json as? [[String: Any]] {
                    
                    for newItem : [String: Any] in list {
                        self.dataSource.append(ModelBeer.init(data: newItem))
                    }
                    
                    self.tableView.backgroundView = nil
                    self.tableView.reloadData()
                }
            } else {
                self.label.text = "Erro ao carregar dados"
                self.tableView.backgroundView = self.label
            }
        }.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "beer", for: indexPath) as! TableViewCell
        let item = dataSource[indexPath.row]
        
        cell.title.text = item.name
        cell.abv.text = "Teor alcoólico: \(item.abv!)"
    
        if let image = URL(string: item.image_url) {
            cell.loadImage(image: image)
        } else {
            cell.imageView?.image = UIImage(named: "placeholder")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // abre detalhes da cerveja
        let details = storyboard?.instantiateViewController(withIdentifier: "details") as! BeerViewController
        
        details.initialize( beer: dataSource[indexPath.row] )
        
        navigationController?.pushViewController(details, animated: true)
        
    }
}

