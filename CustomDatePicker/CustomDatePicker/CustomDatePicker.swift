//
//  CustomDatePicker.swift
//  CustomDatePicker
//
//  Created by Mohamed Shaat on 7/8/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit

enum DatePickerFormatt: String {
    case day = "MMM   d,   yyyy"
    case month = "MMMM   yyyy"
    case year =  "yyyy"
}

protocol DatePickerDelegate {
    func selecteDate(from: Int,to: Int,dateString: String)
    func cancelDialog()
}

public class CustomDatePicker: UIView {
    
    @IBOutlet weak public var doneButton: UIButton!
    @IBOutlet weak public var cancelButton: UIButton!
    @IBOutlet weak public var title: UILabel!
    @IBOutlet weak  var datePicker: UIPickerView!
    public var yearsOffset = -10
    var datePickerFormatt: DatePickerFormatt = .day
    var months:[String] = [String]()
    var years:[String] = [String]()
    var daysCount: Int = 0
    var delegate: DatePickerDelegate?
    var selectedDay:Int?
    var selectedMonth:Int?
    var selectedYear:Int?
    var startDate:Date?
    var endDate:Date?
    var formattString:String?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setupDatePickerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setupDatePickerView()
    }
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    func setupDatePickerView() {
        self.datePicker.delegate = self
        self.datePicker.dataSource = self
        self.title.text = "Select Date"
        daysCount = getTotalDays(month: 1)
        months = getAllMonths()
        years = getAllYears()
        selectedYear = Int(years[years.count-1])
        self.datePicker.selectRow(years.count-1, inComponent: 0, animated: true)
        if  datePickerFormatt != .year {
            let monthNumber = getCurrentMonthNumber()
            selectedMonth = monthNumber + 1
            self.datePicker.selectRow(monthNumber, inComponent: 1, animated: true)
        }
        if datePickerFormatt == .day  {
            selectedDay = getCurrentDayNumber()
            self.datePicker.selectRow(getCurrentDayNumber()-1, inComponent: 2, animated: true)
        }
        
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        delegate?.cancelDialog()
    }
    
    @IBAction func doneAction(_ sender: Any) {
        let calendar = Calendar(identifier: .gregorian)
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let now = NSDate()
        var components = gregorian.components([.year, .month, .day], from: now as Date)
        components.month = selectedMonth ?? 1
        components.year = selectedYear
        components.day = selectedDay ?? 1
        let date = calendar.date(from: components)
        switch datePickerFormatt {
        case .day:
            startDate = date
            formattString = startDate?.toString(format:DatePickerFormatt.day.rawValue)
            endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate!)
            break
        case .month:
            startDate = date
            formattString = startDate?.toString(format:DatePickerFormatt.month.rawValue)
            endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate!)
            break
        case .year:
            startDate = date
            formattString = startDate?.toString(format:DatePickerFormatt.year.rawValue)
            endDate = Calendar.current.date(byAdding: .year, value: 1, to: startDate!)
            break
        }
        delegate?.selecteDate(from:Int(startDate?.timeIntervalSince1970 ?? 0), to: Int(endDate?.timeIntervalSince1970 ?? 0), dateString: formattString ?? "")
        self.animateHide()
    }
    
    public class func loadNib() -> CustomDatePicker {
         return fromNib(nibName:"CustomDatePicker")
    }
}

extension CustomDatePicker: UIPickerViewDataSource, UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch  component {
        case 0:
            selectedYear = Int(years[row])
            break
        case 1:
            selectedMonth = row + 1
            daysCount = getTotalDays(month:row + 1)
            break
        case 2:
            selectedDay = row + 1
            break
        default:
            break
        }
        self.datePicker.reloadAllComponents()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch datePickerFormatt {
        case .day :
            return 3
        case .month :
            return 2
        case .year :
            return 1
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return years.count
        case 1:
            return months.count
        case 2:
            return daysCount
        default:
            return daysCount
        }
    }
    
   public  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return years[row]
        case 1:
            return months[row]
        case 2:
            return "\(row + 1)"
        default:
            return "\(row + 1)"
        }
    }
}

extension CustomDatePicker {
    
    func getTotalDays(month:Int)-> Int {
        var dateComponents = DateComponents()
        dateComponents.year = 2018
        dateComponents.month = month
        let calendar = Calendar.current
        let datez = calendar.date(from: dateComponents)
        let interval = calendar.dateInterval(of: .month, for: datez!)!
        let daysCount = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        return daysCount
    }
    
    func getAllMonths()->[String] {
        let formatter = DateFormatter()
        let monthComponents = formatter.monthSymbols
        return monthComponents!
    }
    
    func getCurrentMonth()->String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: now)
    }
    
    func getCurrentMonthNumber()->Int {
        var selectedIndex = 0
        for (index,month) in months.enumerated() {
            if getCurrentMonth() == month {
                selectedIndex = index
                break
            }
        }
        return selectedIndex
    }
    
    func getAllYears()->[String]  {
        return getDates(datePickerFormatt: .year)
    }
    
    func getCurrentDayNumber()->Int {
        let date = Date()
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }
    
    func getDates(datePickerFormatt:DatePickerFormatt) -> [String] {
        var allDates : [String] = []
        var dateFrom =  Date() // First date
        var dateTo = Date()   // Last date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = datePickerFormatt.rawValue
        dateFrom = Calendar.current.date(byAdding: .year, value: yearsOffset, to: Date()) ?? Date()
        dateTo = NSDate() as Date
        while dateFrom <= dateTo {
            allDates.append(dateFormatter.string(from: dateFrom))
            switch (datePickerFormatt){
            case .day:
                dateFrom = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!
                break
            case .month:
                dateFrom = Calendar.current.date(byAdding: .month, value: 1, to: dateFrom)!
                break
            case .year:
                dateFrom = Calendar.current.date(byAdding: .year, value: 1, to: dateFrom)!
                break
            }
        }
        return allDates
    }
    
  
}
