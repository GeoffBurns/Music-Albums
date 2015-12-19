//
//  Music_AlbumsTests.swift
//  Music AlbumsTests
//
//  Created by Geoff Burns on 17/12/2015.
//  Copyright © 2015 Geoff Burns. All rights reserved.
//

import XCTest
@testable import Music_Albums

class AlbumInfoDataManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAlbumInfoDataModel() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let webServices = WebServices()
        let albumDataManager = AlbumInfoDataManager(webServices: webServices)
        
        
        // Test data
        let albumData = ["wrapperType":"collection", "collectionType":"Album", "artistId":1102077, "collectionId":1017461270, "amgArtistId":170437, "artistName":"Eva Cassidy", "collectionName":"The Best of Eva Cassidy", "collectionCensoredName":"The Best of Eva Cassidy", "artistViewUrl":"https://itunes.apple.com/us/artist/eva-cassidy/id1102077?uo=4", "collectionViewUrl":"https://itunes.apple.com/us/album/the-best-of-eva-cassidy/id1017461270?uo=4", "artworkUrl60":"http://is2.mzstatic.com/image/thumb/Music1/v4/b0/b4/55/b0b45533-5d59-73ed-358f-6b3e8679d013/source/60x60bb.jpg", "artworkUrl100":"http://is2.mzstatic.com/image/thumb/Music1/v4/b0/b4/55/b0b45533-5d59-73ed-358f-6b3e8679d013/source/100x100bb.jpg", "collectionPrice":9.99, "collectionExplicitness":"notExplicit", "trackCount":20, "copyright":"℗ 2000 Blix Street Records Inc.", "country":"USA", "currency":"USD", "releaseDate":"2015-07-31T07:00:00Z", "primaryGenreName":"Pop"]
  
        
      let album =   albumDataManager.albumInfoDataModelFor(albumData)
        
      XCTAssert(album.title=="The Best of Eva Cassidy", "Title incorrect")
        
      XCTAssert(album.price=="$9.99", "Price incorrect")
        
      XCTAssert(album.artist=="Eva Cassidy", "Artist incorrect")
    }
    
    func testAlbumInfoDataModels() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let webServices = WebServices()
        let albumDataManager = AlbumInfoDataManager(webServices: webServices)
        
        
        // Test data
        let albumsData = [
            ["wrapperType":"collection", "collectionType":"Album", "artistId":1102077, "collectionId":1017461270, "amgArtistId":170437, "artistName":"Eva Cassidy", "collectionName":"The Best of Eva Cassidy", "collectionCensoredName":"The Best of Eva Cassidy", "artistViewUrl":"https://itunes.apple.com/us/artist/eva-cassidy/id1102077?uo=4", "collectionViewUrl":"https://itunes.apple.com/us/album/the-best-of-eva-cassidy/id1017461270?uo=4", "artworkUrl60":"http://is2.mzstatic.com/image/thumb/Music1/v4/b0/b4/55/b0b45533-5d59-73ed-358f-6b3e8679d013/source/60x60bb.jpg", "artworkUrl100":"http://is2.mzstatic.com/image/thumb/Music1/v4/b0/b4/55/b0b45533-5d59-73ed-358f-6b3e8679d013/source/100x100bb.jpg", "collectionPrice":9.99, "collectionExplicitness":"notExplicit", "trackCount":20, "copyright":"℗ 2000 Blix Street Records Inc.", "country":"USA", "currency":"USD", "releaseDate":"2015-07-31T07:00:00Z", "primaryGenreName":"Pop"],
            ["wrapperType":"collection", "collectionType":"Album", "artistId":1102077, "collectionId":1059606897, "amgArtistId":170437, "artistName":"Eva Cassidy", "collectionName":"Nightbird (Live)", "collectionCensoredName":"Nightbird (Live)", "artistViewUrl":"https://itunes.apple.com/us/artist/eva-cassidy/id1102077?uo=4", "collectionViewUrl":"https://itunes.apple.com/us/album/nightbird-live/id1059606897?uo=4", "artworkUrl60":"http://is1.mzstatic.com/image/thumb/Music69/v4/24/6b/46/246b46dd-6a23-082d-46b3-366cfc4ad04b/source/60x60bb.jpg", "artworkUrl100":"http://is1.mzstatic.com/image/thumb/Music69/v4/24/6b/46/246b46dd-6a23-082d-46b3-366cfc4ad04b/source/100x100bb.jpg", "collectionPrice":19.99, "collectionExplicitness":"notExplicit", "trackCount":33, "copyright":"℗ 2015 Licensed by Blix Street Records, Inc. from Barbara and Hugh Cassidy", "country":"USA", "currency":"USD", "releaseDate":"2015-12-11T08:00:00Z", "primaryGenreName":"Pop"]]

        //
        //  let data = string.dataUsingEncoding(NSUTF8StringEncoding)
        
        //  webServices.convertDataToDictionary(data)
        
        let albums =   albumDataManager.albumInfoDataModelsFor(albumsData)
        
        XCTAssert(albums.count==2, "count incorrect")
        

    }
    

}
