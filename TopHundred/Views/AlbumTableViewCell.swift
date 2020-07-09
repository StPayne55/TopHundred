//
//  AlbumTableViewCell.swift
//  TopHundred
//
//  Created by Stephen Payne on 7/9/20.
//  Copyright © 2020 Stephen Payne. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let cellID = "AlbumCell"
    private var albumImageView = UIImageView()
    private var albumNameLabel = UILabel()
    private var artistNameLabel = UILabel()


    // MARK: - Init
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier) //This way we get easy access to the cell's built-in 'detailTextLabel'
    }


    // MARK: - Cell Configuration
    func configureCell(album: Album) {
        configureUIElements(album: album)
    }
    
    private func configureUIElements(album: Album) {
        /// AlbumImageView Configuration
        albumImageView.backgroundColor = UIColor.white
        albumImageView.clipsToBounds = true
        albumImageView.layer.masksToBounds = true
        
        if let imageURL = URL(string: album.artworkUrl100) {
            albumImageView.downloadImageFrom(url: imageURL, contentMode: .scaleAspectFit)
        } else {
            albumImageView.image = UIImage(named: "missingArt")
        }

        /// AlbumNameLabel Configuration
        albumNameLabel.text = album.name
        albumNameLabel.textColor = .darkText
        albumNameLabel.font = .systemFont(ofSize: 15.0, weight: .medium)
        albumNameLabel.textAlignment = .left
        
        /// ArtistNameLabel Configuration
        artistNameLabel.text = album.artistName
        artistNameLabel.textColor = .darkGray
        artistNameLabel.font = .systemFont(ofSize: 15.0, weight: .medium)
        artistNameLabel.textAlignment = .left

        contentView.addSubview(albumImageView)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(albumNameLabel)

        /// AlbumImageView Constraints
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            albumImageView.widthAnchor.constraint(equalToConstant: 57),
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0),
            albumImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0)
        ])
        
        /// AlbumNameLabel Constraints
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumNameLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 10.0),
            albumNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            albumNameLabel.topAnchor.constraint(equalTo: albumImageView.topAnchor, constant: 10.0),
            albumNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        /// ArtistNameLabel Constraints
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artistNameLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 10.0),
            artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            artistNameLabel.bottomAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: -10.0),
            artistNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
