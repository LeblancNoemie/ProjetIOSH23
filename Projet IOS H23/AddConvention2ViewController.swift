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

}
