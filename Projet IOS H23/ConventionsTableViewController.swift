//
//  DepensesTableViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-18.
//

import UIKit



class ConventionTableViewCell: UITableViewCell {

    @IBOutlet weak var nom_convention: UILabel!
    @IBOutlet weak var nom_fournisseur: UILabel!
    @IBOutlet weak var montant_convention: UILabel!
    @IBOutlet weak var date_fin: UILabel!
    
    @IBOutlet weak var deleteConvention: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

class ConventionsTableViewController: UITableViewController, WhenConventionsReady {
    func loadData(data: [aConvention]) {
        DispatchQueue.main.async {
            self.apiData =  data
            //print("loadData : \(data)")
            //print(self.depensesAPI)
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConventionCellIdentifier", for: indexPath) as! ConventionTableViewCell
        
        print(apiData)
        let convention = apiData.sorted(by: { $0.date_fin < $1.date_fin})[indexPath.row]
        print(convention.type_convention)
        
        cell.date_fin.text = convention.date_fin.formatted()
        cell.nom_convention.text = convention.type_convention
        cell.nom_fournisseur.text = convention.fournisseur
        cell.montant_convention.text = "\(String(describing: convention.date_fin)) $"
        return cell
    }
}
