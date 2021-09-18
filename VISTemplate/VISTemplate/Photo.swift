//
//  Photo.swift
//  VISTemplate
//
//  Created by Alaa Gaber on 9/18/21.
//

import Foundation

struct Photo: Decodable{
    var id: String
    var author: String
    var width: Int
    var height : Int
    var url: String
    var download_url: String
    
    enum CodingKeys: String, CodingKey {
       case id = "id"
       case author = "author"
       case width = "width"
       case height = "height"
       case url = "url"
       case download_url = "download_url"
     }
}
