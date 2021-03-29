//
//  TestTableViewCell.swift
//  IOS_Task
//
//  Created by mohamed hashem on 29/03/2021.
//

import UIKit

class TestTableViewCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
