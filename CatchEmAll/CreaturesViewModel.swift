//
//  CreaturesViewModel.swift
//  CatchEmAll
//
//  Created by Mohamed Said on 12/8/22.
//

import Foundation

@MainActor
class CreaturesViewModel: ObservableObject {
    
    private struct Returned: Codable {
        var count: Int
        var next: String?
        var results: [Creature]
    }
    
    
    @Published var urlString = "https://pokeapi.co/api/v2/pokemon/"
    @Published var count = 0
    @Published var creaturesArray: [Creature] = []
    @Published var isLoading = true
    
    func getData() async {
        print("We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Couldn't create url from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("JSON ERROR")
                isLoading = false
                return
            }
            self.count = returned.count
            self.urlString = returned.next ?? ""
            self.creaturesArray = self.creaturesArray + returned.results
            isLoading = false
        } catch {
            print("Couldn't use \(urlString) to get data and response")
            isLoading = false
        }
    }
    
    func loadNextIfNeeded(creature: Creature) async {
        
        guard let lastCreature = creaturesArray.last else {
            return
        }
        
        
        if creature.id == lastCreature.id && urlString.hasPrefix("http") {
            Task {
                await getData()
            }
        }
        
    }
    
    func loadAll() async {
        guard urlString.hasPrefix("http") else {return}
        
        await getData()
        await loadAll()
    }
    
}
