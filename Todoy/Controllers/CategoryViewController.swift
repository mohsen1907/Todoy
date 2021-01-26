//
//  CategoryViewController.swift
//  Todoy
//
//  Created by Mohamed on 1/13/21.
//  Copyright © 2021 Mohamed. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

   
    let Context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request : NSFetchRequest<Category> = Category.fetchRequest()
    var CategoryArray = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CategoryArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = CategoryArray[indexPath.row]
        cell.textLabel?.text=category.name
        return cell
    }
    
    
    //MARK: - Table Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory=CategoryArray[indexPath.row]
        }
        
    }

    
    
    
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
        let newCategory = Category(context: self.Context)
            newCategory.name=textField.text!
            self.CategoryArray.append(newCategory)
            self.saveData()
        }
        alert.addTextField { (UITextField) in
            UITextField.placeholder="Enter new category"
            textField=UITextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
       }
    
    //MARK: - Data Manupulation Methods
    func saveData(){
        do {
            try Context.save()
        } catch{
            print("Encoding Error \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData(with request: NSFetchRequest<Category>=Category.fetchRequest()){
        do {
            try CategoryArray = try Context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }

    
}
