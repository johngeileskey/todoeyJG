//
//  ViewController.swift
//  todoeyJG
//
//  Created by John Geileskey on 22/3/18.
//  Copyright © 2018 John Geileskey. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [String]() // ["John", "Cheryl", "Meigan", "Kylie", "Nathan", "Travis"]
    let defaults = UserDefaults.standard  // use user defaults to store small bits of user data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray = items
        }
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("Selected \(itemArray[indexPath.row])")
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new Todoey item", message: "enter new item here ", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print ("Success")
            print (alert.textFields![0].text!)
            self.itemArray.append(alert.textFields![0].text!)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Type in new Item..."
           // print (alertTextField.text!)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}

