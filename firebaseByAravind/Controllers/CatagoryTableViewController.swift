//
//  CatagoryTableViewController.swift
//  firebaseByAravind
//
//  Created by Aravind on 13/01/19.
//  Copyright © 2019 Aravind. All rights reserved.
//

import UIKit
import CoreData

class CatagoryTableViewController: UITableViewController {
    var itemarray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        loaddata()
        
    }

    // MARK: - Table view data source

 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return itemarray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = itemarray[indexPath.row].name
        return cell
    }
    
    //MARK: - TableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //        context.delete(itemarray[indexPath.row])
        //        itemarray.remove(at: indexPath.row)
        //        savedata()
        performSegue(withIdentifier: "gotoitems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TableViewController
        if let indexpath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = itemarray[indexpath.row]
            
        }
    
    }
    
    
    //MARK: - Add new items

    @IBAction func addnewitem(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (alert) in
            let newitem = Category(context: self.context)
            newitem.name=textfield.text
            self.itemarray.append(newitem)
            self.savedata()
        }
        alert.addTextField { (text) in
            text.placeholder = "Enter the New Category"
            textfield=text
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    //MARK: - Saving and Retrieving
    
    func savedata(){
        
        do{
            try context.save()
        }catch{
            print("Error Savind Data \(error)")
        }
        tableView.reloadData()
    }
    func loaddata(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        
        do{
            itemarray = try context.fetch(request)
        }catch{
            print("Error Loading Data \(error)")
        }
        tableView.reloadData()
    }
    
    
}
