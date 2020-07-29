//
//  AlarmDetailTableViewController.swift
//  AlarmProject
//
//  Created by Ian Becker on 7/28/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    //MARK: - Outlets
       
       @IBOutlet weak var datePicker: UIDatePicker!
       @IBOutlet weak var setName: UITextField!
       @IBOutlet weak var enableButton: UIButton!
       
       var alarm: Alarm?
       
       var alarmIsOn: Bool = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Actions
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        alarmIsOn.toggle()
        enableButton.setTitle(alarmIsOn ? "On" : "Off", for: .normal)
        enableButton.backgroundColor = alarmIsOn ? .green : .red
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = setName.text else {return}
        let date = datePicker.date
        let enabled = alarmIsOn
        
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, fireDate: date, name: name, isEnabled: enabled)
        } else {
            AlarmController.shared.addAlarm(fireDate: date, name: name, isEnabled: enabled)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Methods
    private func updateViews() {
        if let alarm = alarm {
            alarmIsOn = alarm.enabled
            datePicker.date = alarm.fireDate
            setName.text = alarm.name
        }
        enableButton.setTitle(alarmIsOn ? "On" : "Off", for: .normal)
        enableButton.backgroundColor = alarmIsOn ? .green : .red
    }
}
