//
//  ManageProject2ViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//

import UIKit

class ManageProject2ViewController: UIViewController {

    @IBOutlet weak var txtlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var dataManagerText :String = "test"
        ProjectDataManager.shared.initProjets()
        
        
        for element in ProjectDAO.shared.getAllProjects() {
            //dataManagerText.append(element.nom!)
            print(element.nom!)
        }
        
        txtlabel.text = dataManagerText
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
