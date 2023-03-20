//
//  DepensesTableViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-18.
//

import UIKit

class DepenseTableViewCell: UITableViewCell {

    @IBOutlet weak var depense_type: UILabel!
    @IBOutlet weak var depense_date: UILabel!
    @IBOutlet weak var depense_prix: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

class DepensesTableViewController: UITableViewController {

    var _projectName : String = ""
    
    var displayType : Int16 = 0 //0 => projet; 1 => Compte
    var _compteName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Data received: \(_projectName)")
        
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
