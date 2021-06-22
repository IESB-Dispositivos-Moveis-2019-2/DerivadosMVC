//
//  ViewController.swift
//  EnderecoMVP
//
//  Created by Pedro Henrique on 21/06/21.
//

import UIKit

class ViewController: UIViewController {
    
    var presenter: EnderecoViewPresenter!
    
    @IBOutlet weak var cepTextField: UITextField!
    
    var enderecoStack: UIStackView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = EnderecoPresenter(view: self)
    }

    @IBAction func onBuscarEndereco(_ sender: UIButton) {
        if let cep = cepTextField.text, cep.count == 8 {
            presenter.obterEndereco(com: cep)
        }
    }
    
}


extension ViewController: EnderecoPresentingView {
    
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
