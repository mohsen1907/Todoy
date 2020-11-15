//
//  ViewController.swift
//  Todoy
//
//  Created by Mohamed on 11/15/20.
//  Copyright © 2020 Mohamed. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    let ItemArray = ["Find Mike", "Buy eggos", "destory Demorgann"]
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text=ItemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }else{
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }

            tableView.deselectRow(at: indexPath, animated: true)
        }
    }


