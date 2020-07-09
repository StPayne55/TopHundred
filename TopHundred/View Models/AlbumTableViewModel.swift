//
//  AlbumTableViewModel.swift
//  TopHundred
//
//  Created by Stephen Payne on 6/27/20.
//  Copyright © 2020 Stephen Payne. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Album Table View Model Delegate
protocol AlbumTableViewModelDelegate: class {
    func albumDataSourceWasUpdated()
    func errorOccurredWhileRetrieving(error: ResponseServerError)
}

// MARK: - Album Detail View Model
class AlbumDetailViewModel {
    var album: Album?
    
    init(album: Album) {
        self.album = album
    }
}

// MARK: - Album Table View Model
class AlbumTableViewModel {
    weak var delegate: AlbumTableViewModelDelegate?
    var dataSource: [Album]?
    
    init(delegate: AlbumTableViewModelDelegate) {
        self.delegate = delegate
        retrieveAlbums(url: AlbumFetcher.iTunesURL)
    }
    
    func retrieveAlbums(url: URL?, completion: (() -> ())? = nil) {
        guard let url = url else {
            self.delegate?.errorOccurredWhileRetrieving(error: .sessionError(error: ResponseServerError.invalidURL))
            completion?()
            return
        }

        AlbumFetcher.shared.retrieveAlbums(url: url) { (albums, error) in
            if let e = error {
                DispatchQueue.main.async {
                    self.delegate?.errorOccurredWhileRetrieving(error: .sessionError(error: e))
                    completion?()
                }
            } else {
                self.dataSource = albums
                self.delegate?.albumDataSourceWasUpdated()
                completion?()
            }
        }
    }
}

// MARK: - Models
struct Root: Codable {
    let feed: Feed
}

/// Feed
struct Feed: Codable {
    let title, id, copyright, country, icon, updated: String
    let author: Author
    let links: [Link]
    let results: [Album]
}

/// Author
struct Author: Codable {
    let name, uri: String
}

/// Link
struct Link: Codable {
    let linkSelf, alternate: String?

    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
        case alternate
    }
}

/// Album
struct Album: Codable {
    let artistName, id, releaseDate, copyright, artworkUrl100, url,  name: String
    let genres: [Genre]

    func genreText() -> String {
        let genreStringArray = genres.prefix(3).map({ return $0.name }) /// Return only 3 genres at most for sake of simplicity
        return genreStringArray.joined(separator: " | ")
    }
    
    func releaseDateFormattedString() -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"

        if let date = dateFormatterGet.date(from: releaseDate) {
            return "Released on \(dateFormatterPrint.string(from: date))"
        }
        
        return nil
    }
}

/// Genre
struct Genre: Codable {
    let genreID, name, url: String

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}
