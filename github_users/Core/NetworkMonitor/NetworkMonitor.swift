//
//  NetworkCheck.swift
//  github_users
//
//  Created by Pritam Biswas on 14.07.2024.
//

import Network
import Combine

class NetworkMonitor: ObservableObject {
    private var monitor: NWPathMonitor
    private var queue: DispatchQueue
    @Published var isConnected: Bool = false
    
    init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            let status = path.status == .satisfied
            DispatchQueue.main.async {
                self.isConnected = status
            }
        }
        self.monitor.start(queue: self.queue)
    }
    
    deinit {
        self.monitor.cancel()
    }
}


