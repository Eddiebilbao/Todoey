//
//  ViewController.swift
//  Todoey
//
//  Created by User on 15/06/2019.
//  Copyright © 2019 Nader Kaabi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike","Buy Eggos","Destory Demogorgon"]
    // interface to userdefaults database where storing key-value paires persistently across lunching our App
    let defaults = UserDefaults.standard

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if  let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }

    
    
   //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    //MARK - tableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        print(indexPath.row)
        print(itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {  tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
  
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alret = UIAlertController(title: "AddNew Todoey Item", message: "wrtie anything here", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlret
            // print("Success!")
            //print(textfield.text!)
            self.itemArray.append(textfield.text!)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            
        }
            alret.addTextField {
                (alretTextField) in
                alretTextField.placeholder = " Create new item "
                textfield = alretTextField
        }
        
        alret.addAction(action)
        present(alret, animated: true, completion: nil)
    }
    
}

