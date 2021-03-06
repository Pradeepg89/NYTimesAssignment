//
//  NYTimesMostViewedFeedTableViewCell.swift
//  NYTimesAssignment
//
//  Created by Pradeep Pandey on 01/09/18.
//  Copyright © 2018 Pradeep Pandey. All rights reserved.
//

import UIKit

class NYTimesMostViewedFeedTableViewCell: UITableViewCell {

    @IBOutlet var feedTitleLabel: UILabel!
    @IBOutlet var feedDescriptionLabel: UILabel!
    @IBOutlet var feedIconImageView: UIImageView!
    @IBOutlet var feedDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
