//
//  ViewController.swift
//  Todoy
//
//  Created by Mohamed on 11/15/20.
//  Copyright © 2020 Mohamed. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let defaults = UserDefaults.standard
    var ItemArray = [Item]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       let newItem = Item()
        newItem.title="Milk shake"
        ItemArray.append(newItem)
       
        let newItem1 = Item()
        newItem1.title="Choclate"
        ItemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title="Banana"
        ItemArray.append(newItem2)
        
        
        if let Items = defaults.array(forKey: "ToDoListArray")   as? [Item]{
            ItemArray = Items
        }
    }
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemArray.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let Item = ItemArray[indexPath.row]
        cell.textLabel?.text=Item.title
        cell.accessoryType = Item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//               if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//                tableView.cellForRow(at: indexPath)?.accessoryType = .none
//            }else{
//                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//            }
//
        ItemArray[indexPath.row].done = !ItemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)

    }
    

    @IBAction func addButtonpressed(_ sender: UIBarButtonItem) {
       
        var  textField = UITextField()
        
        let alert = UIAlertController(title: "Add item", message: "", preferredStyle: .alert)
       
        let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
        
        let newItem = Item()
        newItem.title=textField.text!
        
        self.ItemArray.append(newItem)
        self.defaults.set(self.ItemArray, forKey: "ToDoListArray")
        self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Enter new Item"
            textField=alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

    


