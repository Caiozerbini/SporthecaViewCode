//
//  Networking.swift
//  viewCode
//
//  Created by Caio Carneiro on 31/10/22.
//

import Foundation
import Alamofire

class Networking {
    
    let host: String = "https://sportsmatch.com.br"
    let endPoint: String = "/teste/teste.json"
    
    func getData(success: @escaping (Player) -> Void, failure: @escaping (Error) -> Void) {
        guard let url = URL(string: "\(host)\(endPoint)") else {
            let error = NSError(domain: "Failed to generate URL", code: -1, userInfo: nil)
            failure(error)
            return
        }
        AF.request(url).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    let error = NSError(domain: "Failed to get Data", code: -1, userInfo: nil)
                    failure(error)
                    return
                }
                guard let responseData = try? JSONDecoder().decode(PlayerResponse.self, from: data) else {
                    let error = NSError(domain: "Failed to Parse Data", code: -1, userInfo: nil)
                    failure(error)
                    return
                }
                success(responseData.object.first!)
                break
            case .failure(let error):
                failure(error)
                break
            }
        }
    }
    
}
