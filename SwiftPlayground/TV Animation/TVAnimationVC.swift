//
//  TVAnimationVC.swift
//  SwiftPlayground
//
//  Created by Marchell on 13/03/21.
//

import UIKit

class TVAnimationVC: UIViewController {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(TVAnimationCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
    private func animateVertically(_ tableView: UITableView, for cell: UITableViewCell, with indexPath: IndexPath) {
        if let lastIndexPath = tableView.indexPathsForVisibleRows?.last {
            if lastIndexPath.row <= indexPath.row {
                cell.center.y += cell.frame.height / 2
                cell.alpha = 0
                UIView.animate(withDuration: 0.8, delay: 0.03 * Double(indexPath.row), options: .curveEaseInOut, animations: {
                    cell.center.y -= cell.frame.height / 2
                    cell.alpha = 1
                })
            }
        }
    }
    
    private func animateHorizontally(_ tableView: UITableView, for cell: UITableViewCell, with indexPath: IndexPath) {
        if let lastIndexPath = tableView.indexPathsForVisibleRows?.last {
            if lastIndexPath.row <= indexPath.row {
                cell.frame.origin.x = -cell.frame.width
                cell.alpha = 0
                UIView.animate(withDuration: 0.8, delay: 0.03 * Double(indexPath.row), usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    cell.frame.origin.x = 0
                    cell.alpha = 1
                })
            }
        }
    }

}

extension TVAnimationVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TVAnimationCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        animateVertically(tableView, for: cell, with: indexPath)
        //animateHorizontally(tableView, for: cell, with: indexPath)
    }
}
