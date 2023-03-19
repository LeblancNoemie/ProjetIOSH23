//
//  ManageProject2ViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//

import UIKit

class ManageProject2ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _projectNameLabel.text = projectName
//        totalDepensesLabel.text = "\(ProjectDAO.shared.getTotalSpending(projectName: projectName! )) $"
    }
    
    @IBOutlet weak var _projectNameLabel: UILabel!
    var projectName : String?

    @IBOutlet weak var totalDepensesLabel: UILabel!
    

}
