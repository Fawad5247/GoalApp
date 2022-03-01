//
//  ViewController.swift
//  Goal_HW
//
//  Created by fawad akhtar on 10/1/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func progressBotton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "ProgressViewController") as! ProgressViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func completedBotton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "CompletedViewController") as! CompletedViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

