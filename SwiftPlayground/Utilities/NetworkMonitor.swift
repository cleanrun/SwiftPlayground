//
//  NetworkMonitor.swift
//  SwiftPlayground
//
//  Created by Marchell on 13/03/21.
//

import Foundation
import UIKit
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
            
            if path.status != .satisfied {
                DispatchQueue.main.async {
                    self?.showNoConnectionAlert()
                }
            } else {
                DispatchQueue.main.async {
                    self?.dismissNoConnectionAlert()
                }
            }
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
    
    private func showNoConnectionAlert() {
        let alert = UIAlertController(title: "No Connection", message: "You have no connection, please reconnect to the Internet", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        window?.currentViewController()?.present(alert, animated: true, completion: nil)
    }
    
    private func dismissNoConnectionAlert() {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        window?.currentViewController()?.dismiss(animated: true, completion: nil)
    }
}
