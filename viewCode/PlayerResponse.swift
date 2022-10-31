//
//  PlayerResponse.swift
//  viewCode
//
//  Created by Caio Carneiro on 31/10/22.
//

import Foundation

struct PlayerResponse: Decodable {
    
    let object: [Player]
    
    private enum CodingKeys: String, CodingKey {
        case object = "Object"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        object = try values.decode([Player].self, forKey: .object)
    }
}
