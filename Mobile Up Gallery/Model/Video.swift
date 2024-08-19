//
//  Video.swift
//  Mobile Up Gallery
//
//  Created by Ivan Elonov on 18.08.2024.
//

struct VideosResponse: Decodable {
    var response: VideoResponse
}

struct VideoResponse: Decodable {
    var count: Int
    var items: [Video]
}

struct Video: Decodable {
    var id: Int
    var owner_id: Int
    var title: String
    var duration: Int
    var description: String?
    var date: Int
    var views: Int?
    var player: String
    var image: [VideoImage]?
    
    var imageUrl: String? {
        return image?.first(where: { $0.width >= 700 && $0.height >= 300 })?.url

    }
}

struct VideoImage: Decodable {
    var url: String
    var width: Int
    var height: Int
    var with_padding: Int?
}


