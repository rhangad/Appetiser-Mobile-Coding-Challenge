//
//  DetailViewController.swift
//  Appetiser Mobile Coding Challenge
//
//  Created by Dev Partners on 3/21/19.
//  Copyright © 2019 Dev Partners. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailItem: Track?

    @IBOutlet weak var artworkImage: UIImageView!
    @IBOutlet weak var trackNameText: UILabel!
    @IBOutlet weak var artistNameText: UILabel!
    @IBOutlet weak var genreText: UILabel!
    @IBOutlet weak var priceText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UserDefaults().isDetailView(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        UserDefaults().isDetailView(false)
    }

    // MARK: - Configure View
    func configureView() {
        if let track = detailItem {
            
            trackNameText.text = track.trackName ?? "No title available"
            artistNameText.text = track.artistName ?? "No artist information available"
            genreText.text = track.primaryGenreName ?? "No genre information available"
            priceText.text = "$\(track.trackPrice ?? "0")"
            descriptionText.text = track.longDescription ?? "No description available"
            
            if track.artworkUrl100 != nil {
                // Replace 100 with 900 to load more higher res image
                let url = URL(string: track.artworkUrl100!.replacingOccurrences(of: "100", with: "900"))
                
                //Load image using Kingfisher library
                artworkImage.kf.indicatorType = .activity
                artworkImage.kf.setImage(with: url, placeholder: UIImage(named: "artwork-placeholder"), options: [.scaleFactor(UIScreen.main.scale), .transition(.fade(1)), .cacheOriginalImage])
            }
        }
    }
}

