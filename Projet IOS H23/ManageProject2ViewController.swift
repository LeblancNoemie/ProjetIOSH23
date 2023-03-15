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
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var _projectNameLabel: UILabel!
    var projectName : String?

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
