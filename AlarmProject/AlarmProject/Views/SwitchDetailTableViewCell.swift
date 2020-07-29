//
//  SwitchDetailTableViewCell.swift
//  AlarmProject
//
//  Created by Ian Becker on 7/28/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchDetailTableViewCell)
}

class SwitchDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: SwitchTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Action
    @IBAction func switchValueChanged(_ sender: Any) {
        guard let delegate = delegate else {return}
        delegate.switchCellSwitchValueChanged(cell: self)
    }
    
    func updateViews() {
        guard let alarm = alarm else {return}
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
    }

}

