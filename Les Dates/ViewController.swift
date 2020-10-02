//
//  ViewController.swift
//  Les Dates
//
//  Created by Rodolphe DUPUY on 02/10/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var dateStringLbl: UILabel! // String
    @IBOutlet weak var timeIntervalLbl: UILabel! // Interval
    @IBOutlet weak var calendarLbl: UILabel! // moment
    @IBOutlet weak var ilyaLbl: UILabel! // * mois, jours, heure
    
    let format = "EEEE dd MMMM yy - HH:mm:ss - zzzz"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todayDate.text = Date().toString()
    }

    @IBAction func datePickerChoice(_ sender: UIDatePicker) {
        let date = sender.date
        //dateStringLbl.text = date.toString()
        dateStringLbl.text = date.stringWithFormat(format: format)
        timeIntervalLbl.text = date.timeStamp()
        calendarLbl.text = date.quelJour()
        ilyaLbl.text = date.components()
    }
    
}

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "fr-FR")
        return formatter.string(from: self)
    }
    
    func stringWithFormat(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "es-ES")
        return formatter.string(from: self)
    }
    
    func timeStamp() -> String {
        let tempsEcoule = self.timeIntervalSinceNow
        return String(format: "%.2f", tempsEcoule)
    }
    
    func quelJour() -> String {
        var str = ""
        let cal = Calendar.current
        if cal.isDateInToday(self) {
            str += "Aujourd'hui "
        }
        if cal.isDateInYesterday(self) {
            str += "Hier "
        }
        if cal.isDateInTomorrow(self) {
            str += "Demain "
        }
        if cal.isDateInWeekend(self) {
            str += "Week-End "
        }
        return str
    }
    
    func components() -> String {
        let cal = Calendar.current
        let components = cal.dateComponents([.month, .day, .hour, .minute], from: self, to: Date())
        let month = components.month ?? 0
        let day = components.day ?? 0
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        return "Temps écoulé -> mois: \(month), jour(s): \(day), heure(s): \(hour), minute(s): \(minute)"
    }
}

