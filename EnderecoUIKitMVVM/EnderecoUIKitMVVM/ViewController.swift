//
//  ViewController.swift
//  EnderecoUIKitMVVM
//
//  Created by Pedro Henrique on 21/06/21.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var cepTextField: UITextField!
    var enderecoStack: UIStackView?
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = EnderecoViewModel(fetcher: EnderecoFetcher())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinds()
    }
    
    private func setupBinds() {
        viewModel.$endereco
            .sink { [weak self] endereco in
                guard let endereco = endereco else { return }
                self?.mostrarEnderecoCom(uf: endereco.uf,
                                   localidade: endereco.localidade,
                                   logradouro: endereco.logradouro,
                                   bairro: endereco.bairro)
            }
            .store(in: &subscriptions)
    }

    @IBAction func onBuscarEndereco(_ sender: UIButton) {
        if let cep = cepTextField.text {
            viewModel.cep = cep
        }
    }
    
    func mostrarEnderecoCom(uf: String, localidade: String, logradouro: String, bairro: String) {
        if let stack = enderecoStack {
            stack.removeFromSuperview()
            enderecoStack = nil
        }
        
        let stack = UIStackView(arrangedSubviews: [])
        
        [uf, localidade, logradouro, bairro].map { text -> UILabel in
            let label = UILabel()
            label.text = text
            label.numberOfLines = 1
            label.sizeToFit()
            return label
        }.forEach(stack.addArrangedSubview(_:))
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        
        let height = stack.arrangedSubviews.map({$0.frame.height}).reduce(0, +)
        stack.frame = CGRect(origin: .zero, size: CGSize(width: view.frame.width - 48, height: height))
        stack.center = view.center
        
        stack.setNeedsLayout()
        view.addSubview(stack)
        enderecoStack = stack
        
    }

}

