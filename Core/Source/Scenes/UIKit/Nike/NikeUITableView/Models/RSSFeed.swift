//
//  RSSFeed.swift
//  Core
//
//  Created by Daniel Tarazona on 5/26/21.
//

import Foundation

enum RSSFeedCategory: String, CaseIterable {
    case ALL
}

class RSSFeedRequestObject: RequestObject {
    required init() {
        super.init()
        self.URL = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-songs/all/100/explicit.json"
    }
}

// MARK: - Album
class RSSFeed: Codable, Initializable {
    required init() {}
    
    var feed: Feed?

    init(feed: Feed?) {
        self.feed = feed
    }
}

// MARK: - Feed
class Feed: Codable, Initializable {
    required init() {}
    
    var title: String?
    var id: String?
    var author: Author?
    var links: [Link]?
    var copyright, country: String?
    var icon: String?
    var updated: String?
    var albums: [Album]?
    
    enum CodingKeys: String, CodingKey {
        case albums = "results"
    }

    init(title: String?, id: String?, author: Author?, links: [Link]?, copyright: String?, country: String?, icon: String?, updated: String?, albums: [Album]?) {
        self.title = title
        self.id = id
        self.author = author
        self.links = links
        self.copyright = copyright
        self.country = country
        self.icon = icon
        self.updated = updated
        self.albums = albums
    }
}

// MARK: - Author
class Author: Codable {
    var name: String?
    var uri: String?

    init(name: String?, uri: String?) {
        self.name = name
        self.uri = uri
    }
}

// MARK: - Link
class Link: Codable {
    var linkSelf: String?
    var alternate: String?

    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
        case alternate
    }

    init(linkSelf: String?, alternate: String?) {
        self.linkSelf = linkSelf
        self.alternate = alternate
    }
}

// MARK: - Result
class Album: Codable, Initializable {
    required init() { }
    
    var artistName, id, releaseDate, name: String?
    var copyright, artistId: String?
    var contentAdvisoryRating: ContentAdvisoryRating?
    var artistUrl: String?
    var artworkUrl100: String?
    var genres: [Genre]?
    var url: String?

    init(artistName: String?, id: String?, releaseDate: String?, name: String?, copyright: String?, artistId: String?, contentAdvisoryRating: ContentAdvisoryRating?, artistUrl: String?, artworkUrl100: String?, genres: [Genre]?, url: String?) {
        self.artistName = artistName
        self.id = id
        self.releaseDate = releaseDate
        self.name = name
        self.copyright = copyright
        self.artistId = artistId
        self.contentAdvisoryRating = contentAdvisoryRating
        self.artistUrl = artistUrl
        self.artworkUrl100 = artworkUrl100
        self.genres = genres
        self.url = url
    }
}

enum ContentAdvisoryRating: String, Codable {
    case explicit = "Explicit"
}

// MARK: - Genre
class Genre: Codable {
    var genreId, name: String?
    var url: String?

    init(genreId: String?, name: String?, url: String?) {
        self.genreId = genreId
        self.name = name
        self.url = url
    }
}

