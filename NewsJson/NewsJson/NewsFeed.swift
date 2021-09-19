//
//  NewsFeed.swift
//  NewsJson
//
//  Created by René Zelada on 7/12/21.
//

import Foundation

struct NewsFeed: Codable {
    var Status : String = ""
    var totalResults : Int = 0
    var articles:[Article]
}
