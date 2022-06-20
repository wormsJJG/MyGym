//
//  UserListTableViewCell.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/20.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
