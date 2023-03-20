//
//  AddDepense2ViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//

import UIKit

class AddDepense2ViewController: UIViewController{
    
    @IBOutlet weak var _typeDepense: UITextField!
    @IBOutlet weak var _prixDepense: UITextField!
    @IBOutlet weak var _dateLabel: UILabel!
    @IBOutlet weak var _datePicker: UIDatePicker!
    @IBOutlet weak var _choixModePaiement: UIButton!
    @IBOutlet weak var _choixCompte: UIButton!
    
    var _projectname : String = ""
    var selectedPaymentType: String = "Chèque"
    var selectedCompte : String = "Banque Nationale"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setModePaiementBtn()
        setCompteBtn()
    }
    
    func setModePaiementBtn(){
        let actionClosure = {(action : UIAction) in
            if action.title == "Chèque"{
                self._dateLabel.isHidden = false
                self._datePicker.isHidden = false
            }else {
                self._dateLabel.isHidden = true
                self._datePicker.isHidden = true
            }
            self.selectedPaymentType = action.title
        }
        
        _choixModePaiement.menu = UIMenu(children : [
            UIAction(title:"Chèque", state: .on, handler: actionClosure),
            UIAction(title:"Espèce", handler: actionClosure)])
        _choixModePaiement.showsMenuAsPrimaryAction =  true
        _choixModePaiement.changesSelectionAsPrimaryAction = true
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

    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        
        if(identifier == "DepenseVersManageProjet"){
            if(_typeDepense.hasText && _prixDepense.hasText && (Double(_prixDepense.text!) ?? 0) > 0)
            {
                var depenseDM : DepensesDataManager = DepensesDataManager()
                var projetDAO : ProjectDAO = ProjectDAO()
                var compteDAO : CompteDAO = CompteDAO()
                
                if (depenseDM.saveDepense(prj: projetDAO.getProjectByName(name: _projectname), cpt: compteDAO.getByName(bank_name: _choixCompte.currentTitle!), datePaiement: _datePicker.date, dps_id: 0, mode: _choixModePaiement.currentTitle!, prx: Double(_prixDepense.text!) ?? 0, type: _typeDepense.text!))
                {
                    return true
                } else
                {
                    let alert = UIAlertController(title: "Ajout de Dépense.", message: "Valeur Invalide dans les champs.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
                            }))
                    self.present(alert, animated: true, completion: nil)
                    
                    return false
                }
            }
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        @IBOutlet weak var _typeDepense: UITextField!
//        @IBOutlet weak var _prixDepense: UITextField!
//        @IBOutlet weak var _dateLabel: UILabel!
//        @IBOutlet weak var _datePicker: UIDatePicker!
//        @IBOutlet weak var _choixModePaiement: UIButton!
//        @IBOutlet weak var _choixCompte: UIButton!
        
        //TODO:
        /*
         Vérifier que les champs sont pas vides
         Ajouter une dépense
         Débiter le compte choisi du montant de la dépense
         Reafficher ManageProject
         */
    }

}
