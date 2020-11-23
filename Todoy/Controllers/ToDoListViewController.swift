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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadData()
        
    }
    
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
        
        ItemArray[indexPath.row].done = !ItemArray[indexPath.row].done
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    @IBAction func addButtonpressed(_ sender: UIBarButtonItem) {
        
        var  textField = UITextField()
        
        let alert = UIAlertController(title: "Add item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            let newItem = Item()
            newItem.title=textField.text!
            self.ItemArray.append(newItem)
            self.saveData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Enter new Item"
            textField=alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveData(){
        
        let encoder = PropertyListEncoder()
        do{
            let data =  try encoder.encode(self.ItemArray)
            try data.write(to: self.dataFilePath!)
        }catch{
            print("Encoding error \(error)")
        }
        //        self.defaults.set(self.ItemArray, forKey: "ToDoListArray")
        
        self.tableView.reloadData()
        
    }
    
    func loadData(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                ItemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("decoding error \(error)")
            }
            
        }
    }
}
