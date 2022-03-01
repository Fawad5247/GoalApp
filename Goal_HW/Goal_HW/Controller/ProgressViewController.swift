//
//  ProgressViewController.swift
//  Goal_HW
//
//  Created by fawad akhtar on 10/1/21.
//

import UIKit

class ProgressViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var inProgress: [Progress] {
        
        return CoreDataController.shared.inProgress
    }
    

    @IBAction func plusBotton(_ sender: Any) {
        let alert = UIAlertController(title: "New Goal", message: "Add a new gool", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "save", style: .default) { [unowned self] action in
            guard let textField = alert.textFields?.first,
                  let safeGoal = textField.text
            else {return}
            CoreDataController.shared.addGoal(goal: safeGoal)
            tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

extension ProgressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inProgress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "progressCell") as! progressCell
        
        cell.progressLabel.text = inProgress[indexPath.row].goal
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completed = UIContextualAction(style: .normal, title: "Completed") { (action, view, nil) in
            let currentGoal = self.inProgress[indexPath.row]
            CoreDataController.shared.completedGoal(goal: (currentGoal.value(forKey: "goal") as? String)!)
            let itemToDelete = self.inProgress[indexPath.row]
            CoreDataController.shared.removeProgressGoal(goal: itemToDelete.goal!)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        completed.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        let swipe = UISwipeActionsConfiguration(actions: [completed])
        return swipe
    }
    
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            let itemToDelete = self.inProgress[indexPath.row]
            CoreDataController.shared.removeProgressGoal(goal: itemToDelete.goal!)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
    
}
