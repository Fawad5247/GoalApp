//
//  CompletedViewController.swift
//  Goal_HW
//
//  Created by fawad akhtar on 10/1/21.
//

import UIKit

class CompletedViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    var completed: [Completed] {
        return CoreDataController.shared.completed
    }
}

extension CompletedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "completedCell") as! completedCell
        cell.completeLabel.text = completed[indexPath.row].goal
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            let itemToDelete = self.completed[indexPath.row]
            CoreDataController.shared.removeCompletedGoal(goal: itemToDelete.goal!)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
