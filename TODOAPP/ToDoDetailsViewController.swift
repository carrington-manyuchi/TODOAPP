//
//  ToDoDetailsViewController.swift
//  TODOAPP
//
//  Created by Carrington Tafadzwa Manyuchi on 2023/01/11.
//

import UIKit

class ToDoDetailsViewController: UIViewController {

    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskDetailsTextView: UITextView!
    @IBOutlet weak var taskCompletionButton: UIButton!
    @IBOutlet weak var taskCompletionDate: UILabel!    
    
    var toDoItem: ToDoItem!
    
    var toDoIndex: Int!
    
    weak var delegate: ToDoListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        taskTitleLabel.text = toDoItem.name
        taskDetailsTextView.text = toDoItem.details
        
        if toDoItem.isComplete {
            disableButton()
            
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyy hh:mm"
        
        let taskDate = formatter.string(from: toDoItem.completionDate)
        
        taskCompletionDate.text = taskDate
    }
    
    func disableButton() {
        taskCompletionButton.backgroundColor = UIColor.gray
        taskCompletionButton.isEnabled = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func taskDidComplete(_ sender: Any) {
        
        toDoItem.isComplete = true
        delegate?.update(task: toDoItem, index: toDoIndex)
        disableButton()
    }
    
}
