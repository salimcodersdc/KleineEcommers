//
//  Bundle+Extension.swift
//  ArchitectureTestingApp
//
//  Created by Yousef on 10/26/21.
//

import Foundation

extension Bundle {
    func ObjectFromJson<T: Decodable>(type: T.Type,fileName: String, complition: (Result<T, Error>) -> Void) {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "") else {
            complition(.failure(CustomError.fileNotFound(fileName)))
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {
            complition(.failure(CustomError.failToGetData))
            return
        }
        
        
        let decoder = JSONDecoder()
        let dateFormatter = Date.dateFormatter()
        
        //"12/nov/2021 13:24"
        dateFormatter.dateFormat = "dd/MMM/yyyy HH:mm"
        
        
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        guard let result = try? decoder.decode(T.self, from: data) else {
            complition(.failure(CustomError.failToDecode))
            return
        }
        
        complition(.success(result))
        
    }
    
    enum CustomError: Error, LocalizedError {
        case fileNotFound(String), failToGetData, failToDecode
        
        var errorDescription: String? {
            switch self {
            
            
            case .fileNotFound(let fileName):
                return "Can't find file: \(fileName)"
            case .failToGetData:
                return "Can't get data from file"
            case .failToDecode:
                return "Some of your data are corrpted"
            }
        }
    }
}
