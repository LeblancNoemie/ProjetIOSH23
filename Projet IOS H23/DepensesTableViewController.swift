//
//  DepensesTableViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-18.
//

import UIKit

protocol DepenseTableViewCellDelegate:AnyObject{
    func didButtonTap(itemId: String)
}

class DepenseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nom_depense: UILabel!
    @IBOutlet weak var type_paiement: UILabel!
    @IBOutlet weak var date_paiement: UILabel!
    @IBOutlet weak var montant_depense: UILabel!
    @IBOutlet weak var deleteDepense: UIButton!
    
    var depenseId : String = ""
    var delegate : DepenseTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func onDeleteClick(_ sender: Any) {
        delegate?.didButtonTap(itemId: depenseId)
    }
}

class DepensesTableViewController: UITableViewController, WhenDepensesReady, DepenseTableViewCellDelegate {
    func didButtonTap(itemId: String) {
        let alert = UIAlertController(title: "Supprimer une dépense", message: "Etes-vous certain de vouloir supprimer cette dépense? Les changements ne pourront pas être réversés.",         preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Supprimer", style: UIAlertAction.Style.destructive, handler: { _ in
            var webApi : DepenseRestAPI = DepenseRestAPI()
            webApi.deleteDepense(id: itemId)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Annuler",
                                      style: UIAlertAction.Style.cancel,
                                      handler: {(_: UIAlertAction!) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    var _projectName : String = ""
    var _projectID : String = ""
    var displayType : Int16 = 0 //0 => projet; 1 => Compte
    var _compteName : String = ""
    
    func loadData(data: [aDepense]) {
        DispatchQueue.main.async {
            self.apiData =  data
            self.tableView.reloadData()
        }
    }
    var apiData:[aDepense] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Data received: \(_projectName)")
        let depensesAPI =  DepenseRestAPI()
        depensesAPI.whenDepensesReady = self
        depensesAPI.getDepensesBy(condition: "projetId", value: _projectID)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiData.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 100.0;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepenseCellIdentifier", for: indexPath) as! DepenseTableViewCell
        
        let depense = apiData.sorted(by: {$0.date_paiement < $1.date_paiement})[indexPath.row]
        cell.date_paiement.text = String(depense.date_paiement.formatted())
        cell.montant_depense.text = "\(String(describing: depense.prix)) $"
        cell.nom_depense.text = depense.type_depense
        cell.type_paiement.text = depense.mode_paiement
        cell.depenseId = depense.id
        cell.delegate = self
        return cell
    }
}

