//
//  SavedNewsTableViewCell.swift
//  NewsApp
//
//  Created by Muazzez Aydın on 16.09.2023.
//

import UIKit

class SavedNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsSavedImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
