//
//  DetailView.swift
//  CatchEmAll
//
//  Created by Mohamed Said on 12/9/22.
//

import SwiftUI

struct DetailView: View {
    @StateObject var creatureDetailVM = CreatureDetailViewModel()
    var creature: Creature
    var body: some View {
        VStack (alignment: .leading, spacing: 3) {
            Text(creature.name.capitalized)
                .font(Font.custom("Avenir Next Condensed", size: 60))
                .bold()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.black)
                .padding(.bottom)
            
            HStack {
               
                
                AsyncImage(url: URL(string: creatureDetailVM.imageUrl)) { image in
                        image
                        .resizable()
                        .scaledToFit()
                        .backgroundStyle(.white)
                        .frame(width: 96, height: 96)
                        .cornerRadius(16)
                        .shadow(radius: 8, x: 5, y: 5)
                        .overlay{
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray.opacity(0.5), lineWidth: 1)
                        }
                        .padding(.trailing)
                } placeholder: {
                      RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue)
                        .frame(width: 96, height: 96)
                        .padding(.trailing)
                }
                
                
                VStack (alignment: .leading) {
                    HStack {
                        Text("Height:")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.red)
                        
                        Text(String(format: "%.2f", creatureDetailVM.height))
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.black)
                        
                    }
                    
                    HStack {
                        Text("Weight:")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.red)
                        
                        Text(String(format: "%.2f", creatureDetailVM.weight))
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.black)
                        
                    }
                }
            }
            
            
            
            Spacer()
        }
        .padding()
        .task {
            creatureDetailVM.urlString = creature.url
            await creatureDetailVM.getData()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(creature: Creature(name: "bulbasaur", url: ""))
    }
}
