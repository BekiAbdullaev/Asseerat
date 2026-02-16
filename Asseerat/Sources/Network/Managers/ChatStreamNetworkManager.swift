//
//  ChatStreamNetworkManager.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 31/01/26.
//

import Foundation

final class ChatStreamNetworkManager: NSObject {
    
    // MARK: - Properties
    private var buffer = ""
    private var task: URLSessionDataTask?
    private let baseURL: String
    
    // Callbacks
    var onDataReceived: ((String) -> Void)?
    var onComplete: ((Result<Void, Error>) -> Void)?
    
    private lazy var session: URLSession = {
        URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: nil
        )
    }()
    
    // MARK: - Initialization
    init(baseURL: String = "http://194.135.85.227:8081/api/ai/ask-question/stream") {
        self.baseURL = baseURL
        super.init()
    }
    
    // MARK: - Public Methods
    func startStream(with requestBody: AssistantAIModel.Request.AIAskQuestion, onDataReceived: @escaping (String) -> Void, onComplete: @escaping (Result<Void, Error>) -> Void) {
        
        self.onDataReceived = onDataReceived
        self.onComplete = onComplete
        
        guard let url = URL(string: baseURL) else {
            onComplete(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("text/event-stream", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("en", forHTTPHeaderField: "Accept-Language")
        request.setValue(SecurityBean.shared.getDeviceID(), forHTTPHeaderField: "devicecode")
        request.setValue("Bearer \(SecurityBean.shared.token)", forHTTPHeaderField: "Authorization")
        request.setValue("I", forHTTPHeaderField: "device")
        request.setValue("1", forHTTPHeaderField: "version")
        
        do {
            request.httpBody = try JSONEncoder().encode(requestBody)
        } catch {
            onComplete(.failure(NetworkError.encodingFailed))
            return
        }
        
        // Cancel existing task if any
        stop()
        
        task = session.dataTask(with: request)
        task?.resume()
    }
    
    func stop() {
        task?.cancel()
        task = nil
        buffer = ""
    }
    
    // MARK: - Private Methods
    private func processBuffer() {
        // SSE events end with \n\n
        while let range = buffer.range(of: "\n\n") {
            let rawEvent = String(buffer[..<range.lowerBound])
            buffer.removeSubrange(..<range.upperBound)
            parseSSEEvent(rawEvent)
        }
    }
    
    private func parseSSEEvent(_ event: String) {
        let lines = event.components(separatedBy: "\n")
            
        for line in lines {
            if line.hasPrefix("data:") {
                // Don't trim! Keep the spaces as sent by server
                let data = String(line.dropFirst(5))
                
                // Only skip if completely empty
                guard !data.isEmpty else { continue }
                
                // Notify on main thread with original spacing
                DispatchQueue.main.async { [weak self] in
                    self?.onDataReceived?(data)
                }
            }
        }
    }
    
    deinit {
        stop()
    }
}

// MARK: - URLSessionDataDelegate
extension ChatStreamNetworkManager: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        guard let chunk = String(data: data, encoding: .utf8) else { return }
        
        buffer += chunk
        processBuffer()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        DispatchQueue.main.async { [weak self] in
            if let error = error {
                // Check if it was cancelled
                if (error as NSError).code == NSURLErrorCancelled {
                    self?.onComplete?(.success(()))
                } else {
                    self?.onComplete?(.failure(error))
                }
            } else {
                self?.onComplete?(.success(()))
            }
        }
        
        buffer = ""
    }
}

// MARK: - Network Error
enum NetworkError: LocalizedError {
    case invalidURL
    case encodingFailed
    case decodingFailed
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .encodingFailed: return "Failed to encode request"
        case .decodingFailed: return "Failed to decode response"
        case .unknown: return "Unknown error occurred"
        }
    }
}
