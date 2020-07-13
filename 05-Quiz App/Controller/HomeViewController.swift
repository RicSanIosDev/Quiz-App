//
//  HomeViewController.swift
//  05-Quiz App
//
//  Created by Ricardo Sanchez on 7/2/20.
//  Copyright © 2020 Ricardo Sanchez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var temas = ["historia", "variedades"]
    
    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowQuestion" {
            let destinationVC = segue.destination as! ViewController
            let idx = self.tableView.indexPathForSelectedRow!.row
            destinationVC.category  = self.temas[idx]
        }
    }
   
// -MARK : UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.temas.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TemaViewCell", for: indexPath)
        var tema = self.temas[indexPath.row]
        tema = tema.capitalized
        cell.textLabel?.text = tema
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowQuestion", sender: nil)
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowQuestion" {
                let destinationVC = segue.destination as! ViewController
                let idx = self.tableView.indexPathForSelectedRow!.row
                destinationVC.category = self.temas[idx]
            }
        }
    }
}
