//
//  Image.swift
//  Mobile Up Gallery
//
//  Created by Ivan Elonov on 17.08.2024.
//

import Foundation

struct ImagesResponse: Decodable {
    var response: Images
}

struct Images: Decodable {
    var items: [Image]
}

struct Image: Decodable {
    var date: Int
    var sizes: [Size]
    var text: String
    var user_id: Int
    var web_view_token: String
    var has_tags: Bool
    var orig_photo: OrigPhoto
    
    var mediumImageUrl: String? {
        return sizes.first(where: { $0.type == "m" })?.url
    }
}

struct Size: Decodable {
    var height: Int
    var type: String
    var width: Int
    var url: String
}

struct OrigPhoto: Decodable {
    var height: Int
    var type: String
    var url: String
    var width: Int
}
