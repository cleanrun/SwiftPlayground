//
//  PinVC.swift
//  SwiftPlayground
//
//  Created by Marchell on 14/03/21.
//

import UIKit

class PinVC: UIViewController {
    
    var label: UILabel!

    var vcPresent: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelAction))
        
        label = UILabel()
        label.text = "Authenticate"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.addGestureRecognizer(tapGesture)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 300),
            label.heightAnchor.constraint(equalToConstant: 100),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func labelAction() {
        vcPresent?.dismiss(animated: true, completion: nil)
    }

}
