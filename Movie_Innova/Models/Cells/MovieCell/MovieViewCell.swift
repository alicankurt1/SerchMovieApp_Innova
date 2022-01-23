//
//  MovieViewCell.swift
//  Movie_Innova
//
//  Created by Alican Kurt on 23.01.2022.
//

import UIKit

class MovieViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!    
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
