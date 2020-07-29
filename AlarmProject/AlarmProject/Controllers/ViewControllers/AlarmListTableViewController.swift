//
//  AlarmListTableViewController.swift
//  AlarmProject
//
//  Created by Ian Becker on 7/28/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "switchTableViewCell", for: indexPath) as? SwitchDetailTableViewCell else {return UITableViewCell()}

        let alarm = AlarmController.shared.alarms[indexPath.row]
        cell.nameLabel.text = alarm.name
        cell.timeLabel.text = alarm.fireTimeAsString
        cell.alarmSwitch.isOn = alarm.enabled
        
        cell.delegate = self

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarmToDelete = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarmToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? AlarmDetailTableViewController else {return}
            let alarm = AlarmController.shared.alarms[indexPath.row]
            destinationVC.alarm = alarm
        }
    }
}

extension AlarmListTableViewController: SwitchTableViewCellDelegate {
    func switchCellSwitchValueChanged(cell: SwitchDetailTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let alarm = AlarmController.shared.alarms[indexPath.row]
        AlarmController.shared.toggleEnabled(for: alarm)
        cell.updateViews()
    }
}

