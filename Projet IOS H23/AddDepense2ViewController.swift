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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        @IBOutlet weak var _typeDepense: UITextField!
//        @IBOutlet weak var _prixDepense: UITextField!
//        @IBOutlet weak var _dateLabel: UILabel!
//        @IBOutlet weak var _datePicker: UIDatePicker!
//        @IBOutlet weak var _choixModePaiement: UIButton!
//        @IBOutlet weak var _choixCompte: UIButton!
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
