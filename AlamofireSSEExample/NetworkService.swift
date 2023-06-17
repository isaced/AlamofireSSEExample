//
//  NetworkService.swift
//  AlamofireSSEExample
//
//  Created by isaced on 2023/6/17.
//

import Alamofire
import Foundation

/// OpenAI Message
struct ChatMessage: Encodable {
    let role: String
    let content: String
}

/// OpenAI Request
struct ChatRequest: Encodable {
    let model: String
    let stream: Bool
    let messages: [ChatMessage]
}

enum NetworkService {
    /// OpenAI API Token
    static let token = "sk-xxx"

    static func request() {
        let endpoint = URL(string: "https://api.openai.com/v1/chat/completions")!

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json",
            "Cache-Control": "no-cache",
            "Accept": "text/event-stream"
        ]

        let parameters = ChatRequest(model: "gpt-3.5-turbo",
                                     stream: true,
                                     messages: [
                                         ChatMessage(role: "user", content: "1+1=?")
                                     ])

        let request = AF.streamRequest(endpoint,
                                       method: .post,
                                       parameters: parameters,
                                       encoder: JSONParameterEncoder.default,
                                       headers: headers)

        request.responseStream { stream in
            switch stream.event {
            case let .stream(result):
                switch result {
                case let .success(data):
                    let string = String(data: data, encoding: .utf8)
                    print("stream - success: " + (string ?? ""))
                }
            case .complete:
                print("completion...")
            }
        }
    }
}
