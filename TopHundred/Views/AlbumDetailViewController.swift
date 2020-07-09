//
//  AlbumDetailViewController.swift
//  TopHundred
//
//  Created by Stephen Payne on 7/9/20.
//  Copyright © 2020 Stephen Payne. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    // MARK: - Properties
    private var viewModel: AlbumDetailViewModel?
    private var imageView = UIImageView()
    private var viewAlbumButton = UIButton()
    private var albumNameLabel = UILabel()
    private var artistNameLabel = UILabel()
    private var genreLabel = UILabel()
    private var copyrightLabel = UILabel()
    private var releaseDateLabel = UILabel()

    
    // MARK: Init
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    required init(withViewModel viewModel: AlbumDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureUIElements()
        layoutViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        animateElementsIn()
    }
    

    // MARK: - Private Methods
    private func configureViewController() {
        self.view.backgroundColor = .white
    }

    private func configureUIElements() {
        guard let album = viewModel?.album else { return }
        
        /// ImageView Configuration
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageView.layer.cornerRadius = 20.0
        imageView.clipsToBounds = true
        imageView.transform = .init(scaleX: 0.0001, y: 0.0001)

        if let imageURL = URL(string: album.artworkUrl100) {
            imageView.downloadImageFrom(url: imageURL, contentMode: .scaleAspectFit)
        } else {
            self.imageView.image = UIImage(named: "missingArt")
        }

        /// ViewAlbumButton Configuration
        viewAlbumButton.backgroundColor = .systemPink
        viewAlbumButton.titleLabel?.textColor = .white
        viewAlbumButton.layer.cornerRadius = 5.0
        viewAlbumButton.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .bold)
        viewAlbumButton.setTitle("VIEW ALBUM", for: .normal)
        viewAlbumButton.addTarget(nil, action: #selector(viewAlbumButtonWasSelected), for: .touchUpInside)

        /// AlbumNameLabel Configuration
        albumNameLabel.text = album.name
        albumNameLabel.textColor = .darkText
        albumNameLabel.font = .boldSystemFont(ofSize: 20.0)
        albumNameLabel.adjustsFontSizeToFitWidth = true
        albumNameLabel.textAlignment = .center
        albumNameLabel.alpha = 0.0

        /// ArtistNameLabel Configuation
        artistNameLabel.text = album.artistName
        artistNameLabel.textColor = .systemPink
        artistNameLabel.font = .boldSystemFont(ofSize: 30.0)
        artistNameLabel.adjustsFontSizeToFitWidth = true
        artistNameLabel.textAlignment = .center
        artistNameLabel.alpha = 0.0

        /// GenreLabel Configuration
        genreLabel.text = album.genreText()
        genreLabel.textColor = .darkGray
        genreLabel.font = .systemFont(ofSize: 15.0, weight: .medium)
        genreLabel.adjustsFontSizeToFitWidth = true
        genreLabel.textAlignment = .center
        genreLabel.alpha = 0.0

        /// ReleaseDateLabel Configuration
        releaseDateLabel.text = album.releaseDateFormattedString()
        releaseDateLabel.textColor = .gray
        releaseDateLabel.font = .systemFont(ofSize: 15.0, weight: .regular)
        releaseDateLabel.adjustsFontSizeToFitWidth = true
        releaseDateLabel.textAlignment = .center
        releaseDateLabel.alpha = 0.0

        /// CopyrightLabel Configuration
        copyrightLabel.text = album.copyright
        copyrightLabel.textColor = .lightGray
        copyrightLabel.font = .systemFont(ofSize: 15.0, weight: .semibold)
        copyrightLabel.adjustsFontSizeToFitWidth = false
        copyrightLabel.textAlignment = .center
        copyrightLabel.numberOfLines = 0
        copyrightLabel.alpha = 0.0

        view.addSubview(albumNameLabel)
        view.addSubview(artistNameLabel)
        view.addSubview(genreLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(copyrightLabel)
        view.addSubview(viewAlbumButton)
        view.addSubview(imageView)
    }

    private func layoutViews() {
        /// ImageView Contstraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0)
        ])
        
        /// Button Constraints
        viewAlbumButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewAlbumButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewAlbumButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            viewAlbumButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            viewAlbumButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            viewAlbumButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        /// AlbumNameLabel Constraints
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumNameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0.0),
            albumNameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0.0),
            albumNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            albumNameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

        /// ArtistNameLabel Constraints
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artistNameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0.0),
            artistNameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0.0),
            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 0.0),
            artistNameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        /// GenreLabel Constraints
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genreLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0.0),
            genreLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0.0),
            genreLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 10.0),
            genreLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        /// ReleaseDateLabel Constraints
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            releaseDateLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0.0),
            releaseDateLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0.0),
            releaseDateLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 0.0),
            releaseDateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        /// CopyrightLabel Constraints
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            copyrightLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 0.0),
            copyrightLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0.0),
            copyrightLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 0.0)
        ])
    }
    
    private func animateElementsIn() {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.3, options: .allowAnimatedContent, animations: {
            self.imageView.transform = .identity
        }, completion: nil)

        UIView.animate(withDuration: 0.3, delay: 0.1, options: .allowAnimatedContent, animations: {
            self.albumNameLabel.alpha = 1.0
        }, completion: nil)

        UIView.animate(withDuration: 0.3, delay: 0.2, options: .allowAnimatedContent, animations: {
            self.artistNameLabel.alpha = 1.0
        }, completion: nil)
       
        UIView.animate(withDuration: 1.0, delay: 0.3, options: .allowAnimatedContent, animations: {
            self.genreLabel.alpha = 1.0
            self.releaseDateLabel.alpha = 1.0
            self.copyrightLabel.alpha = 1.0
        }, completion: nil)
    }
    
    @objc private func viewAlbumButtonWasSelected() {
        guard let albumURL = viewModel?.album?.url else {
            let alert = UIAlertController(title: "Error", message: "There was no URL provided for this album", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)

            return
        }
        if let url = URL(string: albumURL), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
