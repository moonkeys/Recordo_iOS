//
//  PresetTableViewCell.swift
//  Recordo
//
//  Created by BLANCHARD Guillaume on 11/01/2019.
//  Copyright © 2019 BLANCHARD Guillaume. All rights reserved.
//

import UIKit

class PresetTableViewCell: UITableViewCell {
    
//MARK: Properties
    @IBOutlet weak var nomPreset: UILabel!
    @IBOutlet weak var nbInstru: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
