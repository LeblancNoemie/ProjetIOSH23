//
//  Compte2ViewController.swift
//  Projet IOS H23
//
//  Created by Noemie Leblanc Lessard on 2023-03-10.
//

import UIKit
import FSCalendar


class Compte2ViewController: UIViewController, WhenComptesReady, FSCalendarDataSource, FSCalendarDelegate {

    func loadData(data: [aCompte]) {
        DispatchQueue.main.async {
            self.comptes =  data
            //self.tableView.reloadData()
        }
    }
    var comptes:[aCompte] = []
    
    // - - -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepCalendar()    }

    // - - -
    
    @IBOutlet weak var calendar: FSCalendar!
    
    func highlightDates()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd"
        
        let datesToHighlight = ["2023-05-15", "2023-05-20", "2023-05-25"]
        
        for date in datesToHighlight
        {
            if let highlightedDate = dateFormatter.date(from: date)
            {
                calendar.select(highlightedDate)
            }
        }
    }
    
    func prepCalendar()
    {
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.appearance.headerDateFormat = "MMMM yyyy"
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase
        calendar.appearance.weekdayTextColor = .black
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return calendar.selectedDates.contains(date) ? UIColor.white : UIColor.black
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return calendar.selectedDates.contains(date) ? UIColor.red : nil
    }
    
    // - - -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var name : String = ""
        if (segue.identifier == "VersTBBN") {
            name = "Banque Nationale"
            if DepenseDAO.shared.getByNomBanque(banque_name: name).count == 0
            {
                let alert = UIAlertController(title: "Aucune dépense", message: "Le compte que vous avez sélectionné n'a encore aucune dépense pour le moment. Essayer d'ajouter une dépense ou revenez plus tard.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "D'accord", style: UIAlertAction.Style.default, handler: { _ in }))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            name = "Banque Royale du Canada"
            if DepenseDAO.shared.getByNomBanque(banque_name: name).count == 0
            {
                let alert = UIAlertController(title: "Aucune dépense", message: "Le compte que vous avez sélectionné n'a encore aucune dépense pour le moment. Essayer d'ajouter une dépense ou revenez plus tard.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "D'accord", style: UIAlertAction.Style.default, handler: { _ in }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        let vc = segue.destination as! DepensesTableViewController
        vc._compteName = name
    }
}
