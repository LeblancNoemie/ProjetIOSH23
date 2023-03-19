//
//  AddDepense2ViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//

import UIKit

class AddDepense2ViewController: UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBOutlet weak var _TypeDeDepense: UITextField!
    @IBOutlet weak var _Prix: UITextField!
    @IBOutlet weak var _Date: UIDatePicker!
    @IBOutlet weak var _Projet: UITextField!
    @IBOutlet weak var _MethodeDePaiment: UITextField!
    @IBOutlet weak var _CompteADebiter: UITextField!
    
    @IBAction func OnClickAjouter(_ sender: Any) {
        
        if(_TypeDeDepense.hasText && _Prix.hasText && _Projet.hasText && _MethodeDePaiment.hasText && _CompteADebiter.hasText)
        {
            let depenseDM: DepensesDataManager = DepensesDataManager()
            
            if(depenseDM.saveDepense(prj: _Projet.text, cpt: _CompteADebiter.text, datePaiement: _Date.date, dps_id: 0, mode: _MethodeDePaiment.text, prx: Double(_Prix.text!), type: _TypeDeDepense.text))
            {
                confirmation(msg: "Ajoutée avec succès.")
            }else
            {
                confirmation(msg: "Une erreur s'est produite.")
            }
            
        } else
        {
            let alert = UIAlertController(title: "Manque d'informations.", message: "Remplir tous les champs.",         preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "D'accord", style: UIAlertAction.Style.default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
        }
    }
    
    func confirmation(msg: String)
    {
        let alert = UIAlertController(title: "Ajout de Dépense.", message: msg,         preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
                }))
                self.present(alert, animated: true, completion: nil)
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
