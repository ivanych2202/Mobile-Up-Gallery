//
//  ApiManager.swift
//  Mobile Up Gallery
//
//  Created by Ivan Elonov on 17.08.2024.
//

import Foundation
import Alamofire

class ApiManager {
    
    static let shared = ApiManager()
    
    private let serviceToken = "a01eef9ea01eef9ea01eef9ea1a3051c28aa01ea01eef9ec6deb243546ac4493939bc4a"
    
    func getImages(completion: @escaping ([Image]) -> ()) {
        let url = "https://api.vk.com/method/photos.get"
        let params: Parameters = [
            "access_token": serviceToken,
            "owner_id": "-128666765",
            "album_id": "266276915",
            "v": "5.199"
        ]

        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                do {
                    let imagesResponse = try JSONDecoder().decode(ImagesResponse.self, from: data)
                    let images = imagesResponse.response.items
                    completion(images)
                } catch {
                    print("Failed to decode images: \(error)")
                }
            } else {
                print("No data received")
            }
        }
    }
}
