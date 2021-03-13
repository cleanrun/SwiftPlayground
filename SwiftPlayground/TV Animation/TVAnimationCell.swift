//
//  TVAnimationCell.swift
//  SwiftPlayground
//
//  Created by Marchell on 13/03/21.
//

import UIKit

class TVAnimationCell: UITableViewCell {
    
    var colorView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupUI() {
        colorView = UIView()
        colorView.backgroundColor = .blue
        colorView.layer.cornerRadius = 10
        colorView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(colorView)
        
        NSLayoutConstraint.activate([
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 15),
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            colorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
        ])
    }
}
