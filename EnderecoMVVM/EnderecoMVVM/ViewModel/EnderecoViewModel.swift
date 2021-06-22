//
//  EnderecoViewModel.swift
//  EnderecoMVVM
//
//  Created by Pedro Henrique on 21/06/21.
//

import Combine
import Foundation


class EnderecoViewModel: ObservableObject {
    
    @Published
    var endereco: Endereco?
    
    @Published
    var cep: String = ""
    
    private let fetcher: EnderecoFetcher
    private var disposables = Set<AnyCancellable>()
    
    init(fetcher: EnderecoFetcher) {
        self.fetcher = fetcher
    }
    
    func obterEndereco() {
        guard self.cep.count == 8 else { return }
        
        fetcher.endereco(para: cep)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                    case .failure:
                        self?.endereco = nil //tratar melhor o erro
                    case .finished:
                        break
                }
            } receiveValue: { [weak self] endereco in
                self?.endereco = endereco
            }
            .store(in: &disposables)

    }
    
}
