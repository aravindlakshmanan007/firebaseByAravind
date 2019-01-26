//
//  TableViewController.swift
//  firebaseByAravind
//
//  Created by Aravind on 06/01/19.
//  Copyright © 2019 Aravind. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {
    
    let realm = try! Realm()
    var todoItems : Results<Item>?
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
        return todoItems?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item=todoItems?[indexPath.row]{
        // Configure the cell...
        cell.textLabel?.text=item.title
        cell.accessoryType = item.done == false ? .none : .checkmark
        }
        else{
            cell.textLabel?.text="No Items Added"
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        if let items = todoItems?[indexPath.row]{
            do{
                try realm.write {
                   // realm.delete(items)
                    items.done = !items.done
                }
            }catch{
                print("Error updating")
            }
        }
        
//todoItems?[indexPath.row].done = !todoItems![indexPath.row].done
//        savedata(todoItems)
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
  
   

   
    // MARK: - add item method
    
    @IBAction func additem(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert=UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let alertaction=UIAlertAction(title: "Add item", style: .default) { (alert) in
        if let currentCategory = self.selectedCategory{
            do{
                try self.realm.write {
                    let newitem=Item()
                    let date=Date()
                    let result = date
                    newitem.title=textfield.text!
                    newitem.date = result
                    currentCategory.items.append(newitem)
                }
                print("Successfully saved")
            }catch{
                print("Error saving \(error)")
            }
        }
        self.tableView.reloadData()
        }
        alert.addTextField { (text) in
            text.placeholder="Enter the new item"
            textfield=text
        }
        alert.addAction(alertaction)
        present(alert,animated: true,completion: nil)
    }
    
    
    func savedata(item : Item){
        
        tableView.reloadData()
    }
    
    
    
    func loaddata(){
        
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
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
            todoItems = todoItems?.filter("title CONTAINS[cd] %@",searchBar.text).sorted(byKeyPath: "date", ascending: true)
            tableView.reloadData()
        }
    }
}
