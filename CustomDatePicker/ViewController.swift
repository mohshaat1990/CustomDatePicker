//
//  ViewController.swift
//  CustomDatePicker
//
//  Created by Mohamed Shaat on 7/8/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dateSelectedLabel: UILabel!
    let customDatePicker = CustomDatePicker.fromNib(nibName:"CustomDatePicker")
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func monthAction(_ sender: Any) {
        customDatePicker.datePickerFormatt = .month
        customDatePicker.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: 300)
         customDatePicker.delegate = self
        self.view.addSubview(customDatePicker)
        customDatePicker.setupDatePickerView()
        customDatePicker.animShow()
    }
    
    @IBAction func monthDayYearAction(_ sender: Any) {
        customDatePicker.datePickerFormatt = .day
        customDatePicker.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: 300)
        customDatePicker.delegate = self
        self.view.addSubview(customDatePicker)
        customDatePicker.setupDatePickerView()
        customDatePicker.animShow()
    }
    
    @IBAction func yearAction(_ sender: Any) {
        customDatePicker.datePickerFormatt = .year
        customDatePicker.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: 300)
        customDatePicker.delegate = self
        self.view.addSubview(customDatePicker)
        customDatePicker.setupDatePickerView()
        customDatePicker.animShow()
    }

}

extension ViewController : DatePickerDelegate {
    func cancelDialog() {
         customDatePicker.animHide()
    }
    
    func selecteDate(from: Int, to: Int, dateString: String) {
      dateSelectedLabel.text = dateString
    }
    
}

