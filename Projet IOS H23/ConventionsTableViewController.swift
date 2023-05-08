//
//  DepensesTableViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-18.
//

import UIKit



class ConventionTableViewCell: UITableViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

class ConventionsTableViewController: UITableViewController, WhenConventionsReady {
    func loadData(data: [aConvention]) {
        DispatchQueue.main.async {
            self.conventions =  data
            //print("loadData : \(data)")
            //print(self.depensesAPI)
            //self.tableView.reloadData()
        }
    }
    

    var _projectName : String = ""
    var displayType : Int16 = 0 //0 => projet; 1 => Compte
    var _compteName : String = ""
    
    var conventions:[aConvention] = []
    
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
        // #warning Incomplete implementation, return the number of rows
        if(displayType == 0)
        {
            return DepenseDAO.shared.getByNomProjet(project_name: _projectName).count
        } else
        {
            return DepenseDAO.shared.getByNomBanque(banque_name: _compteName).count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepenseCellIdentifier", for: indexPath) as! DepenseTableViewCell
    
        //Changer le contenu de ça:
        var depenses: [Depense] = []
        if(displayType == 0)
        {
            depenses = DepenseDAO.shared.getByNomProjet(project_name: _projectName)
        }else
        {
            depenses = DepenseDAO.shared.getByNomBanque(banque_name: _compteName)
        }
        
        let depense = depenses.sorted(by: { $0.date_paiement! < $1.date_paiement!})[indexPath.row]
        cell.depense_date.text = depense.date_paiement?.formatted()
        cell.depense_type.text = depense.type_depense
        cell.depense_prix.text = "\(String(describing: depense.prix!)) $"
        return cell
    }
}
