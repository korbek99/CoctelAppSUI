//
//  UtilsEndpoints.swift
//  CoctelApp
//
//  Created by Jose David Bustos H on 11-08-24.
//

import Foundation
class UtilsEndpoints {
    
    public func getEndpoint(fromName: String) -> APIEndpointModel? {
                var endpointFile = ""
                #if DEBUG
                    endpointFile = "endpointsDev"
                #else
                    endpointFile = "endpoints"
                #endif
                debugPrint(endpointFile)
                guard let path = Bundle.main.path(forResource: endpointFile, ofType: "plist") else {
                    debugPrint("ERROR: No se encontró archivo endpoints.plist")
                    return nil
                }
                let myDict = NSDictionary(contentsOfFile: path) as! [String : Any]
                guard let endpoint = myDict[fromName] as? [String : String] else {
                    debugPrint("ERROR: No existe endpoint con el nombre \(fromName)")
                    return nil
                }
                return APIEndpointModel(url: URL(string: endpoint["url"]!)!, APIKey: endpoint["x-api-key"]!, APIToken: endpoint["x-api-token"])
    }
}
