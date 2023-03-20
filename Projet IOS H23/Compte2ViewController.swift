//
//  Compte2ViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//

import UIKit

class Compte2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var name : String = ""
        if (segue.identifier == "VersTBBN") {
            name = "Banque Nationale"
            if DepenseDAO.shared.getByNomBanque(banque_name: name).count == 0
            {
                let alert = UIAlertController(title: "Aucune dépense", message: "Le compte que vous avez sélectionné n'a encore aucune dépense pour le moment. Essayer d'ajouter une dépense ou revenez plus tard.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "D'accord", style: UIAlertAction.Style.default, handler: { _ in }))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            name = "Banque Royale du Canada"
            if DepenseDAO.shared.getByNomBanque(banque_name: name).count == 0
            {
                let alert = UIAlertController(title: "Aucune dépense", message: "Le compte que vous avez sélectionné n'a encore aucune dépense pour le moment. Essayer d'ajouter une dépense ou revenez plus tard.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "D'accord", style: UIAlertAction.Style.default, handler: { _ in }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        let vc = segue.destination as! DepensesTableViewController
        vc._compteName = name
    }
}
