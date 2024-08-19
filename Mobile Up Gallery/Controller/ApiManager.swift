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

    func getImages(completion: @escaping ([Image]) -> ()) {
        guard let userToken = UserDefaults.standard.string(forKey: "userToken"), !userToken.isEmpty else {
            print("User token is missing")
            return
        }
        let url = "https://api.vk.com/method/photos.get"
        let params: Parameters = [
            "access_token": userToken,
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

    func getVideos(completion: @escaping ([Video]) -> ()) {
        guard let userToken = UserDefaults.standard.string(forKey: "userToken"), !userToken.isEmpty else {
            print("User token is missing")
            return
        }

        let url = "https://api.vk.com/method/video.get"
        let params: Parameters = [
            "access_token": userToken,
            "owner_id": "-128666765",
            "album_id": 1, 
            "v": "5.199"
        ]

        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                do {
                    let videosResponse = try JSONDecoder().decode(VideosResponse.self, from: data)
                    let videos = videosResponse.response.items
                    completion(videos)
                } catch {
                    print("Failed to decode videos: \(error)")
                }
            } else {
                print("No data received")
            }
        }
    }
}
