//
//  DepensesTableViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-18.
//

import UIKit

protocol ConventionTableViewCellDelegate:AnyObject{
    func didButtonTap(itemId: String)
}

class ConventionTableViewCell: UITableViewCell {

    @IBOutlet weak var nom_convention: UILabel!
    @IBOutlet weak var nom_fournisseur: UILabel!
    @IBOutlet weak var montant_convention: UILabel!
    @IBOutlet weak var date_fin: UILabel!
    @IBOutlet weak var deleteConvention: UIButton!
    
    var conventionId : String = ""
    weak var delegate : (ConventionTableViewCellDelegate)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func onDeleteConventionClick(_ sender: Any) {
        delegate!.didButtonTap(itemId: conventionId)
    }
}

class ConventionsTableViewController: UITableViewController, WhenConventionsReady, ConventionTableViewCellDelegate {
    func didButtonTap(itemId: String) {
        print("found: \(itemId)")
        let alert = UIAlertController(title: "Supprimer une convention", message: "Etes-vous certain de vouloir supprimer cette convention? Les changements ne pourront pas être réversés.",         preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Supprimer", style: UIAlertAction.Style.destructive, handler: { _ in
            var webApi : ConventionsRestAPI = ConventionsRestAPI()
            webApi.deleteConvention(id: itemId)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Annuler",
                                      style: UIAlertAction.Style.cancel,
                                      handler: {(_: UIAlertAction!) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func loadData(data: [aConvention]) {
        DispatchQueue.main.async {
            self.apiData =  data
            self.tableView.reloadData()
        }
    }
    

    var _projectName : String = ""
    var displayType : Int16 = 0 //0 => projet; 1 => Compte
    var _compteName : String = ""
    
    var apiData:[aConvention] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Data received: \(_projectName)")
        let conventionsAPI =  ConventionsRestAPI()
        conventionsAPI.whenConventionsReady = self
        conventionsAPI.getAllData()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiData.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 100.0;//Your custom row height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConventionCellIdentifier", for: indexPath) as! ConventionTableViewCell
        
        print(apiData)
        let convention = apiData.sorted(by: { $0.date_fin < $1.date_fin})[indexPath.row]
        print(convention.type_convention)
        
        cell.date_fin.text = convention.date_fin.formatted()
        cell.nom_convention.text = convention.type_convention
        cell.nom_fournisseur.text = convention.fournisseur
        cell.montant_convention.text = "\(String(describing: convention.prix)) $"
        cell.conventionId = convention.id
        cell.delegate = self
        return cell
    }
}
