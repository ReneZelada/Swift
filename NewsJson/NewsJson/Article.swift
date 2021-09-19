//
//  Article.swift
//  NewsJson
//
//  Created by René Zelada on 7/12/21.
//

import Foundation

struct Article: Codable {
    
    var  author: String?
    var title: String?
    var description: String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    var content:String?
    
}
