//
//  EnderecoPresenter.swift
//  EnderecoMVP
//
//  Created by Pedro Henrique on 21/06/21.
//

import Foundation

protocol EnderecoPresentingView: AnyObject {
    
    func mostrarEnderecoCom(uf: String, localidade: String, logradouro: String, bairro: String)
    
}

protocol EnderecoViewPresenter: AnyObject {
    
    init(view: EnderecoPresentingView)
    func obterEndereco(com cep: String)
    
}

class EnderecoPresenter: EnderecoViewPresenter {
    
    unowned let view: EnderecoPresentingView
    private let session: URLSession
    
    private let baseURL = "https://viacep.com.br/ws"
    
    required init(view: EnderecoPresentingView) {
        self.view = view
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    
    func obterEndereco(com cep: String) {
        if let url = URL(string: "\(baseURL)/\(cep)/json") {
            session.dataTask(with: url) { [weak self] data, resp, error in
                if let response = resp as? HTTPURLResponse, response.statusCode == 200, let jsonData = data {
                    if let endereco = try? JSONDecoder().decode(Endereco.self, from: jsonData) {
                        DispatchQueue.main.async {
                            self?.view.mostrarEnderecoCom(uf: endereco.uf,
                                                          localidade: endereco.localidade,
                                                          logradouro: endereco.logradouro,
                                                          bairro: endereco.bairro)
                        }
                    }
                }
            }.resume()
        }
    }
    
}
