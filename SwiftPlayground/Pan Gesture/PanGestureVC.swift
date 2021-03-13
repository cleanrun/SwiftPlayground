//
//  PanGestureVC.swift
//  SwiftPlayground
//
//  Created by Marchell on 13/03/21.
//

import UIKit

class PanGestureVC: UIViewController {
    
    var containerView: UIView!
    var panGestureView: UIView!
    
    let screenSize = UIScreen.main.bounds
    var panOriginalCenter: CGPoint?
    var panUp: CGPoint!
    var panDown: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        panGestureView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: screenSize.width, height: screenSize.height)))
        panGestureView.roundCorners([.topRight, .topLeft], radius: 30)
        panGestureView.backgroundColor = .gray
        panGestureView.translatesAutoresizingMaskIntoConstraints = false
        panGestureView.isUserInteractionEnabled = true
        containerView.addSubview(panGestureView)
        
        NSLayoutConstraint.activate([
            panGestureView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            panGestureView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            panGestureView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: screenSize.height * 0.25),
            panGestureView.heightAnchor.constraint(equalToConstant: screenSize.height)
        ])

        panUp = CGPoint(x: panGestureView.center.x, y: panGestureView.center.y + (screenSize.height * 0.25))
        panDown = CGPoint(x: panGestureView.center.x, y: panGestureView.center.y + (screenSize.height * 0.75))
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        panGestureView.addGestureRecognizer(panGesture)
    }
    
    @objc private func panAction(_ sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: panGestureView)
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began:
            panOriginalCenter = panGestureView.center
        case .changed:
            // FIXME: This scrolling length handler needs a rework (the concept is basically correct, but the behavior still needs work)
            if (translation.y > -(screenSize.height * 0.20)) && (translation.y < (screenSize.height * 0.6)) {
                panGestureView.center = CGPoint(x: panOriginalCenter!.x, y: panOriginalCenter!.y + translation.y)
            }
        case .ended:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                if velocity.y < 0 {
                    self.panGestureView.center = self.panUp
                } else {
                    self.panGestureView.center = self.panDown
                }
            })
        default:
            print("default")
        }
    }

}

