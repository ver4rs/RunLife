//
//  WorkoutTableViewCell.swift
//  RuLife
//
//  Created by Martin Sekerák on 08.03.16.
//  Copyright © 2016 Martin Sekerák. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageType: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var decriptionLabel: UILabel!
    
    
    
    @IBOutlet weak var visibleIcon: UIImageView!
    @IBOutlet weak var likeIcon: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
