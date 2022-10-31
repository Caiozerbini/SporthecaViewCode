//
//  Player.swift
//  viewCode
//
//  Created by Caio Carneiro on 31/10/22.
//

import Foundation

struct Player: Decodable {
    
    let imageURL: String
    let name: String
    let percentage: Double
    let position: String
    let country: String
    let worldCupVictories: WorldCupData
    let worldCupPlayed: WorldCupData
    
    private enum RootKeys: String, CodingKey {
        case player = "Player"
    }
    
    private enum CodingKeys: String, CodingKey {
        case img = "img"
        case name = "name"
        case percentage = "percentual"
        case positon = "pos"
        case country = "country"
        case barras = "Barras"
    }
    
    private enum BarrasContainer: String, CodingKey {
        case worldCupVictories = "Copas_do_Mundo_Vencidas"
        case worldCupPlayed = "Copas_do_Mundo_Disputadas"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let playerContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .player )
        imageURL = try playerContainer.decode(String.self, forKey: .img)
        name = try playerContainer.decode(String.self, forKey: .name)
        percentage = try playerContainer.decode(Double.self, forKey: .percentage)
        position = try playerContainer.decode(String.self, forKey: .positon)
        country = try playerContainer.decode(String.self, forKey: .country)
        
        let barrasContainer = try playerContainer.nestedContainer(keyedBy: BarrasContainer.self, forKey: .barras)
        worldCupVictories = try barrasContainer.decode(WorldCupData.self, forKey: .worldCupVictories)
        worldCupPlayed = try barrasContainer.decode(WorldCupData.self, forKey: .worldCupPlayed)
    }
}
