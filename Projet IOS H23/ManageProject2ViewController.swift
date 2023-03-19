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
        _totalDepensesLabel.text = "\(DepenseDAO.shared.getTotalDepenses(project_name: projectName!).formatted()) $"
        
    }
    
    @IBOutlet weak var _totalDepensesLabel: UILabel!
    @IBOutlet weak var _projectNameLabel: UILabel!
    var projectName : String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if DepenseDAO.shared.getByNomProjet(project_name: projectName!).count == 0 && segue.identifier == "VersTableView" {
            let alert = UIAlertController(title: "Aucune dépense", message: "Le projet que vous avez sélectionné n'a encore aucune dépense pour le moment. Essayer d'ajouter une dépense ou revenez plus tard.",         preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "D'accord", style: UIAlertAction.Style.default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
        }else{
            let destination = segue.destination as? DepensesTableViewController
            destination?._projectName = projectName!
        }

    }

}
