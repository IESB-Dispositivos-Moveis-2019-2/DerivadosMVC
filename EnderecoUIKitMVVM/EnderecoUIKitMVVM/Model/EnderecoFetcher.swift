//
//  EnderecoFetcher.swift
//  EnderecoMVVM
//
//  Created by Pedro Henrique on 21/06/21.
//

import Combine
import Foundation

protocol EnderecoFetchable {
    
    func endereco(para cep: String) -> AnyPublisher<Endereco, Error>
    
}

struct EnderecoFetcher {
    
    private let baseURL = "https://viacep.com.br/ws"
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    
}

extension EnderecoFetcher: EnderecoFetchable {
    
    func endereco(para cep: String) -> AnyPublisher<Endereco, Error> {
        if let url = URL(string: "\(baseURL)/\(cep)/json") {
            return session.dataTaskPublisher(for: url)
                .tryMap { (data: Data, resp: URLResponse) in
                    guard let response = resp as? HTTPURLResponse, response.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .decode(type: Endereco.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
    }
    
}
