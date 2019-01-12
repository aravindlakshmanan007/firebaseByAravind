//
//  TableViewController.swift
//  firebaseByAravind
//
//  Created by Aravind on 06/01/19.
//  Copyright © 2019 Aravind. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var itemarray=[item]()
    let arraykey="listitem"
    let db=UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let newitem=item()
        newitem.itemtitle="buy apples"
        itemarray.append(newitem)
//        if let item=db.object(forKey: arraykey) as? [String]{
//           itemarray=item
//        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemarray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item=itemarray[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text=item.itemtitle
        cell.accessoryType = item.done == false ? .none : .checkmark
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemarray[indexPath.row].done = !itemarray[indexPath.row].done
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
   /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - add item method
    
    @IBAction func additem(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert=UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let alertaction=UIAlertAction(title: "Add item", style: .default) { (alert) in
            let newitem=item()
            newitem.itemtitle=textfield.text!
            self.itemarray.append(newitem)
            self.db.set(self.itemarray, forKey: self.arraykey)
            self.tableView.reloadData()
        }
        alert.addTextField { (text) in
            text.placeholder="Enter the new item"
            textfield=text
        }
        alert.addAction(alertaction)
        present(alert,animated: true,completion: nil)
    }
}
