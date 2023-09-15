//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Muazzez Aydın on 15.09.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   
    }

}
