//
//  CategoryViewController.swift
//  Todoy
//
//  Created by Mohamed on 1/13/21.
//  Copyright © 2021 Mohamed. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    let Context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    let request : NSFetchRequest<Category> = Category.fetchRequest()
    var CategoryArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CategoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
       
//        let category = CategoryArray?[indexPath.row] ?? "sad"
        cell.textLabel?.text=CategoryArray?[indexPath.row].name ?? "No Categories"
        return cell
    }
    
    
    //MARK: - Table Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "goToItems", sender: self)
    }
    //What happend when i Clicked any row
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory=CategoryArray?[indexPath.row]
        }
        
    }

    
    
    
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
        let newCategory = Category()
            newCategory.name=textField.text!
//            self.CategoryArray.append(newCategory)
            self.save(category: newCategory)
        }
        alert.addTextField { (UITextField) in
            UITextField.placeholder="Enter new category"
            textField=UITextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
       }
    
    //MARK: - Data Manupulation Methods
    func save(category: Category){
        do {
            try realm.write{
                realm.add(category)
            }
        } catch{
            print("Encoding Error \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData(){
        CategoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }

    
}
