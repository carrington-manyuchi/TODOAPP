//
//  ToDoListViewController.swift
//  TODOAPP
//
//  Created by Carrington Tafadzwa Manyuchi on 2023/01/11.
//

import UIKit

protocol ToDoListDelegate: AnyObject {
    
    func update(task: ToDoItem, index: Int)
}

class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var toDoItems: [ToDoItem] = [ToDoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        
        title = "Carrington's To Do List App"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        
       
        let testItem = ToDoItem(name: "Monday", details: "Going to Mall of Africa", completionDate: Date())
        self.toDoItems.append(testItem)
        
        let testItem2 = ToDoItem(name: "Tuesday", details: "Going to Rosebank Mall", completionDate: Date())
        self.toDoItems.append(testItem2)
      
        //Observer that will wait to hear fom those notifications
        NotificationCenter.default.addObserver(self, selector: #selector(addNewTask(_ :)), name: NSNotification.Name.init("com.carringtons.TODOAPP.addtask"), object: nil)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.setEditing(false, animated: false)
    }
    
    @objc func addNewTask(_ notification: NSNotification) {
        
        var toDoItem: ToDoItem!
        
        if let task = notification.object as? ToDoItem {
            toDoItem = task
        }
        else {
            return
        }
        
        toDoItems.append(toDoItem)
        toDoItems.sort(by: {$0.completionDate > $1.completionDate  })
        
        tableView.reloadData()
        
    }
    
     @objc func addTapped() {
        
        performSegue(withIdentifier: "AddTaskSegue", sender: nil)
        
    }
    
    @objc func editTapped() {
        //making tableview enter into editing mode
        tableView.setEditing(!tableView.isEditing, animated: true)
        
        if tableView.isEditing == true {
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTapped))
        }
        else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            self.toDoItems.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
        }
        
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = toDoItems[indexPath.row]
        
        let toDoTuple = (indexPath.row, selectedItem)
        
        performSegue(withIdentifier: "TaskDetailsSegue", sender: toDoTuple)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let toDoItem = toDoItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem")!
        
        cell.textLabel?.text = toDoItem.name
        
        cell.detailTextLabel?.text = toDoItem.isComplete ? "Complete" : "Incomplete"
        
        return cell
        
        
    }


    // MARK: - Navigation / Passing Data to another vc

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "TaskDetailsSegue" {
            guard let destinationVC = segue.destination as? ToDoDetailsViewController else { return }
            
            guard let toDoTuple = sender as? (Int, ToDoItem) else { return }
            
            destinationVC.toDoIndex = toDoTuple.0
            destinationVC.toDoItem = toDoTuple.1
            
            destinationVC.delegate = self
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init("com.carringtons.TODOAPP.addtask"), object: nil)
    }

}


extension ToDoListViewController: ToDoListDelegate {
    func update(task: ToDoItem, index: Int) {
        toDoItems[index] = task
        
        tableView.reloadData()
    }
    
}
