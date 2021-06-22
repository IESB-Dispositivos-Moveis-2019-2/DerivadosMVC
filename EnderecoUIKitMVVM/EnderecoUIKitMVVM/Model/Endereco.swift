//
//  Endereco.swift
//  EnderecoUIKitMVVM
//
//  Created by Pedro Henrique on 21/06/21.
//

import Foundation

struct Endereco: Codable {
    let cep, logradouro, complemento, bairro: String
    let localidade, uf, ibge, gia: String
    let ddd, siafi: String
}
