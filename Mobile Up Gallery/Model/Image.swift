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
    var imageUrl: String? {
        return sizes.first(where: { $0.type == "q" })?.url ?? sizes.first?.url
    }
}

struct Size: Decodable {
    var height: Int
    var type: String
    var width: Int
    var url: String
}


