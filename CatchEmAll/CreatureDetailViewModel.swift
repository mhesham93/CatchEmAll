//
//  CreatureDetailViewModel.swift
//  CatchEmAll
//
//  Created by Mohamed Said on 12/9/22.
//

import Foundation

@MainActor
class CreatureDetailViewModel: ObservableObject {
    
    private struct Returned: Codable {
        var height: Double
        var weight: Double
        var sprites: Sprite
    }
    
    struct Sprite: Codable {
        var front_default: String?
        var other: Other
    }
    
    struct Other: Codable {
        var officialArtwork: OfficialArtwork
        
        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
    
    
    struct OfficialArtwork: Codable {
        var front_default: String
    }
    
    
    
    
    @Published var urlString = ""
    @Published var height = 0.0
    @Published var weight = 0.0
    @Published var imageUrl = ""
    
    
    
    func getData() async {
        print("We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Couldn't create url from \(urlString)")
            
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("JSON ERROR")
                
                return
            }
            self.height = returned.height
            self.weight = returned.weight
            self.imageUrl = returned.sprites.other.officialArtwork.front_default
            
        } catch {
            print("Couldn't use \(urlString) to get data and response")
            
        }
    }
    
}
