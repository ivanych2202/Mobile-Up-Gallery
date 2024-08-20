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
            completion([])
            return
        }
        
        let url = "https://api.vk.com/method/video.get"
        let params: Parameters = [
            "access_token": userToken,
            "owner_id": "-128666765",
            "album_id": 0,
            "v": "5.199"
        ]
        
        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                do {
                    let videosResponse = try JSONDecoder().decode(VideosResponse.self, from: data)
                    // Фильтруем видео, исключая те, которые содержат YouTube в URL
                    let filteredVideos = videosResponse.response.items.filter { video in
                        return !video.player.lowercased().contains("youtube")
                    }
                    completion(filteredVideos)
                } catch {
                    print("Failed to decode videos: \(error)")
                    completion([])
                }
            } else {
                print("No data received")
                completion([])
            }
        }
    }
    
    func isTokenValid(completion: @escaping (Bool) -> Void) {
        guard let userToken = UserDefaults.standard.string(forKey: "userToken"), !userToken.isEmpty else {
            completion(false)
            return
        }
        
        let url = "https://api.vk.com/method/users.get"
        let params: Parameters = [
            "access_token": userToken,
            "v": "5.199"
        ]
        
        AF.request(url, method: .get, parameters: params).response { response in
            if let data = response.data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dict = json as? [String: Any],
                       let response = dict["response"] as? [[String: Any]],
                       !response.isEmpty {
                        completion(true)
                    }
                } catch {
                    print("Failed to decode token")
                    completion(false)
                }
            }
        }
    }
}

