//
//  AddConvention2ViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//

import UIKit

class AddConvention2ViewController: UIViewController {
    
    @IBOutlet weak var _typeConvention: UITextField!
    @IBOutlet weak var _prixConvention: UITextField!
    @IBOutlet weak var _datePicker: UIDatePicker!
    @IBOutlet weak var _nomFournisseur: UITextField!
    @IBOutlet weak var _choixCompte: UIButton!
    
    var _projectname : String = ""
    var selectedCompte : String = "Banque nationale"

    override func viewDidLoad() {
        super.viewDidLoad()
        setCompteBtn()
    }
    
    func setCompteBtn(){
        let actionClosure = {(action : UIAction) in
            self.selectedCompte = action.title
        }
        _choixCompte.menu = UIMenu(children : [
            UIAction(title:"Banque Nationale", state: .on, handler: actionClosure),
            UIAction(title:"Banque Royale du Canada", handler: actionClosure)])
        _choixCompte.showsMenuAsPrimaryAction =  true
        _choixCompte.changesSelectionAsPrimaryAction = true
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if(_typeConvention.hasText && _prixConvention.hasText && (Double(_prixConvention.text!) ?? 0) > 0 && _nomFournisseur.hasText)
        {
            var conventionDM : ConventionsDataManager = ConventionsDataManager()
            var projetDAO : ProjectDAO = ProjectDAO()
            var compteDM : ComptesDataManager = ComptesDataManager()
            
            if (conventionDM.saveConvention(projet: projetDAO.getProjectByName(name: _projectname), compte: compteDM.getCompteByName(name: _choixCompte.currentTitle!), conv_id: 0, dateFin: _datePicker.date, fournisseur: _nomFournisseur.text!, prix: (Double(_prixConvention.text!) ?? 0), conv_type: _typeConvention.text!))
            {
                compteDM.updateCompte(oldCompteId: compteDM.getCompteByName(name: _choixCompte.currentTitle!).compte_id, newId: compteDM.getCompteByName(name: _choixCompte.currentTitle!).compte_id, newBank: compteDM.getCompteByName(name: _choixCompte.currentTitle!).nom_banque ?? "", newAmount: compteDM.getCompteByName(name: _choixCompte.currentTitle!).montant as! Double - (Double(_prixConvention.text!) ?? 0))
                
                return true
            }
        }
        
        let alert = UIAlertController(title: "Ajout de Convention.", message: "Valeur Invalide dans les champs.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
                }))
        self.present(alert, animated: true, completion: nil)
        
        return false
    }
    
}
