//
//  Accueil2ViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//

import UIKit

class Accueil2ViewController: UIViewController {
    @IBOutlet weak var pp1: UIButton!
    @IBOutlet weak var pp2: UIButton!
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ProjectDataManager.shared.initProjets()
        //DepensesDataManager.shared.initDepenses()
    }
    @IBAction func deleteAllData(_ sender: Any) {
        ProjectDataManager.shared.deleteAll()
        DepensesDataManager.shared.deleteAll()
        
        print("\(ProjectDataManager.shared.getAllProjects().count) ")
        print("\(DepensesDataManager.shared.getAllDepenses().count) ")
    }
    
    @IBAction func onClickButton(_ sender: UIButton) {
        name = sender.titleLabel!.text!
        performSegue(withIdentifier: "projetButtonToProjectManage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "projetButtonToProjectManage") {
            let vc = segue.destination as! ManageProject2ViewController
            vc.projectName = name
        }
    }
     
}
