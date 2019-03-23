//
//  TrackCell.swift
//  Appetiser Mobile Coding Challenge
//
//  Created by Dev Partners on 3/22/19.
//  Copyright © 2019 Dev Partners. All rights reserved.
//

import UIKit
import Kingfisher

class TrackCell: UITableViewCell {
    
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var trackGenre: UILabel!
    @IBOutlet weak var trackPrice: UILabel!
    @IBOutlet weak var trackArtWork: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - Configure Cell
    func configure(with track: Track) {
        trackName.text = track.trackName ?? "No title"
        trackGenre.text = track.primaryGenreName ?? "N/A"
        trackPrice.text = "$\(track.trackPrice ?? "N/A")"
        
        if track.artworkUrl100 != nil {
            //Load image using Kingfisher library
            let url = URL(string: track.artworkUrl100!)
            trackArtWork.kf.indicatorType = .activity
            trackArtWork.kf.setImage(with: url, placeholder: UIImage(named: "artwork-placeholder"), options: [.scaleFactor(UIScreen.main.scale), .transition(.fade(1)), .cacheOriginalImage])
        }
        else {
            
        }
    }
}
