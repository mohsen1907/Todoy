//
//  ViewController.swift
//  Todoy
//
//  Created by Mohamed on 11/15/20.
//  Copyright © 2020 Mohamed. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController{
    
    var todoItems : Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category?{
        didSet{
            loadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text="No Data"
        }
        
        return cell
    }
    
    //MARK: - Table Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let Item = todoItems?[indexPath.row] {
            do {
                try realm .write{
                    Item.done = !Item.done
                }
            } catch{
                print("Error saving done status, \(error)")
            }
        }
//        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    //MARK: - Add New Items
    @IBAction func addButtonpressed(_ sender: UIBarButtonItem) {
        
        var  textField = UITextField()
        let alert = UIAlertController(title: "Add item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            //what will happen once the user clicks the add Item button on our UIAlerrt
            if (self.selectedCategory != nil) {
                do {
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title=textField.text!
//                        newItem.dateCreated=Date()
                        self.selectedCategory?.Items.append(newItem)
                    }
                } catch{
                    print("Error saving new items, \(error)")
                }
            }
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Enter new Item"
            textField=alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //MARK: - Model Manupulation Methods
    func loadData(){
        todoItems = selectedCategory?.Items.sorted(byKeyPath: "title",ascending: true)
        tableView.reloadData()
    }
}




//MARK: - Search bar Methods
extension ToDoListViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
        
        tableView.reloadData()
//        let request : NSFetchRequest<Item>=Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
////        todoItems = try Context.fetch(request)
//
//        loadData(with: request,predicate: predicate)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count==0{
            loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
