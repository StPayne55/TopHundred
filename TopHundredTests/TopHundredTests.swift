//
//  TopHundredTests.swift
//  TopHundredTests
//
//  Created by Stephen Payne on 6/27/20.
//  Copyright © 2020 Stephen Payne. All rights reserved.
//

import XCTest
@testable import TopHundred

class TopHundredTests: XCTestCase {
    var mockedDelegate: AlbumTableViewModelDelegateMock!
    var mockedGenre1: Genre!
    var mockedGenre2: Genre!
    var mockedAlbum: Album!
    
    override func setUp() {
        mockedGenre1 = Genre(genreID: "1", name: "genre1", url: "genreURL")
        mockedGenre2 = Genre(genreID: "2", name: "genre2", url: "genreURL")
        mockedAlbum = Album(artistName: "name", id: "123",
                            releaseDate: "2020-03-03", copyright: "copyright",
                            artworkUrl100: "artworkURL", url: "itunesURL",
                            name: "albumName", genres: [mockedGenre1, mockedGenre2])

        mockedDelegate = AlbumTableViewModelDelegateMock()
    }
    
    func testAlbumTableViewModelInit() {
        let vm = AlbumTableViewModel(delegate: mockedDelegate)

        XCTAssertNotNil(vm.delegate)
    }

    
    func testAlbumDetailViewModelInit() {
        let vm = AlbumDetailViewModel(album: mockedAlbum)

        XCTAssertNotNil(vm.album)
        XCTAssertEqual(vm.album?.genres.first?.name, "genre1")
        XCTAssertEqual(vm.album?.genres.first?.url, "genreURL")
        XCTAssertEqual(vm.album?.genres.first?.genreID, "1")
        XCTAssertEqual(vm.album?.artistName, "name")
        XCTAssertEqual(vm.album?.id, "123")
        XCTAssertEqual(vm.album?.releaseDate, "2020-03-03")
        XCTAssertEqual(vm.album?.copyright, "copyright")
        XCTAssertEqual(vm.album?.artworkUrl100, "artworkURL")
        XCTAssertEqual(vm.album?.url, "itunesURL")
        XCTAssertEqual(vm.album?.name, "albumName")
    }
    
    func testRetrieveAlbums() {
        let vm = AlbumTableViewModel(delegate: mockedDelegate)
        
        let expecation = self.expectation(description: "Retrieving")
        vm.retrieveAlbums(url: AlbumFetcher.iTunesURL) {
            expecation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNotNil(vm.dataSource)
        XCTAssertEqual(mockedDelegate.didUpdateDataSource, true)
    }
    
    func testAlbumGenreText() {
        let text = mockedAlbum.genreText()
        
        XCTAssertEqual(text, "genre1 | genre2")
    }
    
    func testReleaseDataFormattedString() {
        let text = mockedAlbum.releaseDateFormattedString()
        
        XCTAssertEqual(text, "Released on Mar 03, 2020")
    }
    
    func testRetrieveAlbumWithNoURL() {
        let vm = AlbumTableViewModel(delegate: mockedDelegate)
        
        let expecation = self.expectation(description: "Retrieving")
        vm.retrieveAlbums(url: nil) {
            expecation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNotNil(mockedDelegate.error)
    }
    
    func testRetrieveAlbumWithBadURL() {
        let vm = AlbumTableViewModel(delegate: mockedDelegate)
        let url = URL(string: "https://google.com")

        let expecation = self.expectation(description: "Retrieving")
        vm.retrieveAlbums(url: url, completion: {
            expecation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(mockedDelegate.error)
    }
}


class AlbumTableViewModelDelegateMock: AlbumTableViewModelDelegate {
    var didUpdateDataSource: Bool = false
    var error: ResponseServerError?
    
    func albumDataSourceWasUpdated() {
        self.didUpdateDataSource = true
    }
    
    func errorOccurredWhileRetrieving(error: ResponseServerError) {
        self.error = error
    }
}
