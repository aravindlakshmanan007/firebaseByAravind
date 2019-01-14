//
//  TableViewController.swift
//  firebaseByAravind
//
//  Created by Aravind on 06/01/19.
//  Copyright © 2019 Aravind. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var itemarray=[Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedCategory : Category?{
        didSet{
            loaddata()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemarray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item=itemarray[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text=item.title
        cell.accessoryType = item.done == false ? .none : .checkmark
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        context.delete(itemarray[indexPath.row])
//        itemarray.remove(at: indexPath.row)
        itemarray[indexPath.row].done = !itemarray[indexPath.row].done
        savedata()
        tableView.deselectRow(at: indexPath, animated: true)

    }
  
   

   
    // MARK: - add item method
    
    @IBAction func additem(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert=UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let alertaction=UIAlertAction(title: "Add item", style: .default) { (alert) in
            let newitem=Item(context: self.context)
            newitem.title=textfield.text!
            newitem.done = false
            newitem.parentCategory=self.selectedCategory
            self.itemarray.append(newitem)
            self.savedata()
        }
        alert.addTextField { (text) in
            text.placeholder="Enter the new item"
            textfield=text
        }
        alert.addAction(alertaction)
        present(alert,animated: true,completion: nil)
    }
    
    
    func savedata(){
        do{
            try context.save()
            print("Successfully saved")
        }catch{
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    
    
    func loaddata(with request : NSFetchRequest<Item> = Item.fetchRequest(),predicate : NSPredicate? = nil){
        
        let categorypredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)

        if let additionalPredicate = predicate{
            request.predicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicate,additionalPredicate])
        }else{
            request.predicate = categorypredicate
        }
        do{
           itemarray = try context.fetch(request)
        }catch{
            print("Error Requesting data \(error)")
        }
        tableView.reloadData()
    }
}
//MARK: - Search Bar Methods

extension TableViewController : UISearchBarDelegate {
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loaddata()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }else{
            let request : NSFetchRequest<Item> = Item.fetchRequest()

            let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)

            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]

            loaddata(with: request, predicate: predicate)
        }
    }
}
