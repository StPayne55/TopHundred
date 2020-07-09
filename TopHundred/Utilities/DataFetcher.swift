//
//  DataFetcher.swift
//  TopHundred
//
//  Created by Stephen Payne on 6/27/20.
//  Copyright © 2020 Stephen Payne. All rights reserved.
//

import Foundation


// MARK: - Response Server Error Enum
enum ResponseServerError : Error {
    case invalidURL
    case invalidJSON
    case sessionError(error: Error)
    case noAlbumsReturned
    
    func messageForError() -> String {
        switch self {
        case .invalidJSON:
            return "The JSON structure returned is not what was expected"
        case .invalidURL:
            return "The URL provided was formatted incorrectly"
        case .sessionError(let error):
            return error.localizedDescription
        case .noAlbumsReturned:
            return "No albums were provided by iTunes"
        }
    }
}


// MARK: - Data Fetcher
class AlbumFetcher {
    public static let shared = AlbumFetcher()

    /**
     Retrieves Albums from static URL.
     - parameter completion: Closure which provides an optional array of albums, or a server response error.
    */
    func retrieveAlbums(completion: @escaping ([Album]?, ResponseServerError?) -> Void) {
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/itunes-music/top-albums/all/100/explicit.json") else {
            completion(nil, .invalidURL)
            return
        }
        
        if let data = try? Data(contentsOf: url) {
            if let albums = parseAlbumResults(data: data) {
                completion(albums, nil)
            } else {
                completion(nil, .noAlbumsReturned)
            }
            
        }
    }

    private func parseAlbumResults(data: Data) -> [Album]? {
        let decoder = JSONDecoder()

        if let albums = try? decoder.decode(Root.self, from: data).feed.results {
            return albums
        }
        
        return nil
    }
}
