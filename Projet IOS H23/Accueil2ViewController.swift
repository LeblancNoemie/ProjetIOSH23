//
//  Accueil2ViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//

import UIKit

class Accueil2ViewController: UIViewController, WhenProjectsReady {
    @IBOutlet weak var pp1: UIButton!
    @IBOutlet weak var pp2: UIButton!
    
    var name = ""
    
    //TODO: Enlever car pas nécessaire ici.
    func loadData(data: [aProjet]) {
        DispatchQueue.main.async {
            self.apiProjects =  data
            print("loadData : \(data)")
            print(self.apiProjects)
            //self.tableView.reloadData()
        }
    }
    
    //TODO: Enlever car pas nécessaire ici.
    var apiProjects:[aProjet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Enlever car pas nécessaire ici.
        let projectsApi =  ProjetRestAPI()
        projectsApi.whenProjectsReady = self
        projectsApi.getAllData()
        
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
