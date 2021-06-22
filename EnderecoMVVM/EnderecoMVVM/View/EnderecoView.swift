//
//  EnderecoView.swift
//  EnderecoMVVM
//
//  Created by Pedro Henrique on 21/06/21.
//

import SwiftUI

struct EnderecoView: View {
    
    @ObservedObject
    var viewModel: EnderecoViewModel
    
    var body: some View {
        NavigationView {
            Group {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Digite o CEP:")
                    TextField("00000000", text: $viewModel.cep)
                        .padding(.bottom, 24)
                    Button("ACHAR ENDEREÇO") {
                        viewModel.obterEndereco()
                        
                    }
                    if let endereco = viewModel.endereco {
                        VStack(alignment: .leading) {
                            Text(endereco.uf)
                            Text(endereco.localidade)
                            Text(endereco.logradouro)
                            Text(endereco.bairro)
                        }
                        .padding(.top, 32)
                    }
                    Spacer()
                }
            }
            .padding(EdgeInsets(top: 32, leading: 24, bottom: 0, trailing: 24))
            .navigationBarTitle("Ache o endereço", displayMode: .inline)
        }
    }
}
