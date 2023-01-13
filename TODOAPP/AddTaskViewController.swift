//
//  AddTaskViewController.swift
//  TODOAPP
//
//  Created by Carrington Tafadzwa Manyuchi on 2023/01/12.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDetailsTextView: UITextView!
    @IBOutlet weak var taskCompletionDatePicker: UIDatePicker!
    
 

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let navigationItem = UINavigationItem(title: "Add Task")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonDidTouch))
        
        navigationBar.items = [navigationItem]
        
        taskDetailsTextView.layer.borderColor = UIColor.lightGray.cgColor
        taskDetailsTextView.layer.borderWidth = CGFloat(1)
        taskDetailsTextView.layer.cornerRadius = CGFloat(3)
        
        
        //creating a toolbar
        
        let toolBarDone = UIToolbar.init()
        toolBarDone.sizeToFit()
        toolBarDone.barTintColor = UIColor.red
        toolBarDone.isTranslucent = false
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let barBtnDone = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        
        barBtnDone.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        
        toolBarDone.items = [flexSpace, barBtnDone, flexSpace]
        
        taskNameTextField.inputAccessoryView = toolBarDone
        
        taskDetailsTextView.inputAccessoryView = toolBarDone
        

        
        //end creating a toolbar
        
    }
    
    
    
    
    /*
    @objc func dismissKeyboard() {
        view.endEditing(true)
    } */
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    
    @objc func cancelButtonDidTouch() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addTaskDidTouch(_ sender: Any) {
        
        guard let taskName = taskNameTextField.text,
              !taskName.isEmpty else {
            
            // report error
            reportError(title: "Invalid Task Name", message: "Task name is required")
            
            return
        }
        
        if taskDetailsTextView.text.isEmpty {
            
            // report error
            reportError(title: "Invalid Task Details", message: "Task details are required")
            
            return
        }
        
        let taskDetails: String = taskDetailsTextView.text
        
        let completionDate: Date = taskCompletionDatePicker.date
        
        if completionDate < Date() {
            
            // report error
            reportError(title: "Invalid Date", message: "Date must be in the future")
            
            return
        }
        
        let toDoItem = ToDoItem(name: taskName, details: taskDetails, completionDate: completionDate)
        
        // Passing our new toDo Item data from AddTask to ToDoListView controller and append it to the array
        NotificationCenter.default.post(name: NSNotification.Name.init("com.carringtons.TODOAPP.addtask"), object: toDoItem)
        
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
    
    func reportError(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    

}
