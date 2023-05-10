//
//  DepensesTableViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-18.
//

import UIKit



class DepenseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nom_depense: UILabel!
    @IBOutlet weak var type_paiement: UILabel!
    @IBOutlet weak var date_paiement: UILabel!
    @IBOutlet weak var montant_depense: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

class DepensesTableViewController: UITableViewController, WhenDepensesReady {

    var _projectName : String = ""
    
    var displayType : Int16 = 0 //0 => projet; 1 => Compte
    var _compteName : String = ""
    
    func loadData(data: [aDepense]) {
        DispatchQueue.main.async {
            self.apiData =  data
            print("loadData : \(data)")
            //print(self.depensesAPI)
            self.tableView.reloadData()
        }
    }
    var apiData:[aDepense] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Data received: \(_projectName)")
        let depensesAPI =  DepenseRestAPI()
        
        depensesAPI.whenDepensesReady = self
        depensesAPI.getAllData()
        print(apiData)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        if(displayType == 0)
//        {
//            return DepenseDAO.shared.getByNomProjet(project_name: _projectName).count
//        } else
//        {
//            return DepenseDAO.shared.getByNomBanque(banque_name: _compteName).count
//        }
        return apiData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepenseCellIdentifier", for: indexPath) as! DepenseTableViewCell
        
        //var depenses: [aDepense] = []
        
//        if(displayType == 0)
//        {
//            depenses = DepenseDAO.shared.getByNomProjet(project_name: _projectName)
//        }else
//        {
//            depenses = DepenseDAO.shared.getByNomBanque(banque_name: _compteName)
//        }
        //depenses = apiData
        
        let depense = apiData.sorted(by: {$0.date_paiement < $1.date_paiement})[indexPath.row]
        
        cell.date_paiement.text = depense.date_paiement.formatted()
        cell.montant_depense.text = "\(String(describing: depense.prix)) $"
        cell.nom_depense.text = depense.type_depense
        cell.type_paiement.text = depense.mode_paiement
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
