//
//  Accueil2ViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//

import Charts
import UIKit

class Accueil2ViewController: UIViewController, WhenProjectsReady, WhenComptesReady, WhenDepensesReady {
    func loadData(data: [aDepense]) {
            DispatchQueue.main.async {
            self.apiDepense = data
        }
    }
    var apiDepense: [aDepense] = []
    
    // - - - Pie Chart Data \/\/
    
    func loadData(data: [aCompte]) {
        DispatchQueue.main.async {
            self.apiComptes = data
            self.fillChart()
        }
    }
    
    var apiComptes:[aCompte] = []
    
    // - - -
    
    @IBOutlet weak var pp1: UIButton!
    @IBOutlet weak var pp2: UIButton!
    
    var name = ""
    
    //TODO: Enlever car pas nécessaire ici.
    func loadData(data: [aProjet]) {
        DispatchQueue.main.async {
            self.apiProjects =  data
            //print("loadData : \(data)")
            //print(self.apiProjects)
            //self.tableView.reloadData()
        }
    }
    
    //TODO: Enlever car pas nécessaire ici.
    var apiProjects:[aProjet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Enlever car pas nécessaire ici.
        let projectsApi =  ProjetRestAPI()
        projectsApi.whenProjectsReady = self
        projectsApi.getAllData()
        
        // - - - Pie Chart Data \/\/
        
        let comptesAPI = CompteRestAPI()
        comptesAPI.whenComptesReady = self
        comptesAPI.getAllData()
        
        
    }
    
    func fillChart()
    {
        var dataEntries:[PieChartDataEntry] = []
        
        for c: aCompte in apiComptes
        {
            dataEntries.append(PieChartDataEntry(value: c.montant, label: c.nom_banque))
        }
        
        // - - - Pie Chart Set Up \/\/
        
        let dataset = PieChartDataSet(entries: dataEntries, label: "")
        dataset.colors = [.red, .orange, .systemRed, .yellow, .systemOrange, .systemYellow]
        dataset.sliceSpace = 2
        dataset.selectionShift = 5
        let data = PieChartData(dataSet: dataset)
        data.setValueTextColor(.clear)
        //pieChart.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 400, height: 400))
        pieChart.data = data
        pieChart.holeColor = UIColor.clear
        pieChart.legend.textColor = UIColor.white
        pieChart.chartDescription.text = ""
        pieChart.legend.enabled = true
        pieChart.legend.horizontalAlignment = .right
        pieChart.animate(xAxisDuration: 1.5, easingOption: .easeInOutBack)
    }
    
    @IBAction func onClickButton(_ sender: UIButton) {
        name = sender.titleLabel!.text!
        performSegue(withIdentifier: "projetButtonToProjectManage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "projetButtonToProjectManage") {
            let vc = segue.destination as! ManageProject2ViewController
            vc.projectName = name
        }
    }
    
    @IBOutlet weak var pieChart: PieChartView!
}
