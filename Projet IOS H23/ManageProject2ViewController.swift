//
//  ManageProject2ViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//

import UIKit
import Charts

class ManageProject2ViewController: UIViewController, WhenDepensesReady, WhenConventionsReady{
    
    func loadData(data: [aConvention]) {
        DispatchQueue.main.async {
            self.apiConvention = data
            self.fillGraphConvention()
        }
    }
    var apiConvention: [aConvention] = []
    
    func loadData(data: [aDepense]) {
        DispatchQueue.main.async {
            self.apiDepense = data
            self.fillGraphDepense()
        }
    }
    var apiDepense: [aDepense] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _projectNameLabel.text = projectName
        _totalDepensesLabel.text = "\(DepenseDAO.shared.getTotalDepenses(project_name: projectName).formatted()) $"
        
        let depenseAPI = DepenseRestAPI()
        depenseAPI.whenDepensesReady = self
        depenseAPI.getDepensesBy(condition: "projetId", value: projectID) //#TODO passez id
        
        let conventionAPI = ConventionsRestAPI()
        conventionAPI.whenConventionsReady = self
        conventionAPI.getAllData()
    }
    
    func fillGraphDepense()
    {
        var yValuesData:[Double] = []
        for d: aDepense in apiDepense
        {
            yValuesData.append(d.prix)
        }
        
        let depenseEntries = [BarChartDataEntry(x: 1, yValues: yValuesData)]
        let depenseDataSet = BarChartDataSet(entries: depenseEntries, label: "Dépenses")
        depenseDataSet.colors = [.red, .orange, .yellow]
        
        graphDataSets.append(depenseDataSet)
    }
    
    var graphDataSets: [BarChartDataSet] = []
    
    func fillGraphConvention()
    {
        var yValuesData:[Double] = []
        for c in apiConvention
        {
            yValuesData.append(c.prix)
        }
        
        let conventionEntries = [BarChartDataEntry(x:1,  yValues: yValuesData)]
        let conventionDataSet = BarChartDataSet(entries: conventionEntries, label: "Conventions")
        conventionDataSet.colors = [.cyan, .blue, .purple]
        
        graphDataSets.append(conventionDataSet)
    }
    
    func fillGraph()
    {
        let data = BarChartData(dataSets: graphDataSets)
        
        barChart.data = data
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.leftAxis.axisMinimum = 0
        barChart.rightAxis.axisMinimum = 0
        barChart.legend.horizontalAlignment = .center
        barChart.legend.verticalAlignment = .bottom
        barChart.legend.textColor = .white
        barChart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    var projectID: String = ""
    
    // - - -
    
    @IBOutlet weak var _totalDepensesLabel: UILabel!
    @IBOutlet weak var _projectNameLabel: UILabel!
    var projectName : String = ""

 
//Do not go past this.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier)
        if segue.identifier == "addConventionBtnItenfier"{
            let destination = segue.destination as? AddConvention2ViewController
            destination?._projectname = projectName
        }
        if segue.identifier == "addDepenseBtnIdentifier"{
            let destination = segue.destination as? AddDepense2ViewController
            destination?._projectname = projectName
        }
        if segue.identifier == "showProjectDepenses"{
            //let destination = segue.destination as? AddDepense2ViewController
            //destination?._projectname = projectName
                if DepenseDAO.shared.getByNomProjet(project_name: projectName).count == 0 {
                    let alert = UIAlertController(title: "Aucune dépense", message: "Le projet que vous avez sélectionné n'a encore aucune dépense pour le moment. Essayer d'ajouter une dépense ou revenez plus tard.",         preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "D'accord", style: UIAlertAction.Style.default, handler: { _ in
                            }))
                            self.present(alert, animated: true, completion: nil)
                }else{
                    let destination = segue.destination as? DepensesTableViewController
                    destination?._projectName = projectName
                }
            }
        if segue.identifier == "showProjectConventions"{
            //let destination = segue.destination as? AddDepense2ViewController
            //destination?._projectname = projectName
                if DepenseDAO.shared.getByNomProjet(project_name: projectName).count == 0 {
                    let alert = UIAlertController(title: "Aucune conventions", message: "Le projet que vous avez sélectionné n'a encore aucune convention pour le moment. Essayer d'ajouter une convention ou revenez plus tard.",         preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "D'accord", style: UIAlertAction.Style.default, handler: { _ in
                            }))
                            self.present(alert, animated: true, completion: nil)
                }else{
                    let destination = segue.destination as? ConventionsTableViewController
                    destination?._projectName = projectName
                }
            }
        }
    
    
    @IBOutlet weak var barChart: BarChartView!
}
