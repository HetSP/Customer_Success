//
//  projectTableViewCell.swift
//  customerSuccess
//
//  Created by promact on 05/03/24.
//

import UIKit

class projectTableViewCell: UITableViewCell {

    @IBOutlet weak var column1: UILabel!
    
    @IBOutlet weak var column5: UILabel!
    @IBOutlet weak var column4: UILabel!
    @IBOutlet weak var column3: UILabel!
    @IBOutlet weak var column2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
