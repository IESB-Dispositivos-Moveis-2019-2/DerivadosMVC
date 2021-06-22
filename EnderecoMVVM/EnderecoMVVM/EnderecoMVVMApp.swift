//
//  EnderecoMVVMApp.swift
//  EnderecoMVVM
//
//  Created by Pedro Henrique on 21/06/21.
//

import SwiftUI

@main
struct EnderecoMVVMApp: App {
    
    let enderecoViewModel = EnderecoViewModel(fetcher: EnderecoFetcher())
    
    var body: some Scene {
        WindowGroup {
            EnderecoView(viewModel: enderecoViewModel)
        }
    }
}
