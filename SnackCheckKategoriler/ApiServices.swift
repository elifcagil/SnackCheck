//
//  ApiServices.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 16.03.2025.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()  // Singleton: Tek bir örnek oluştur
    private init() {} // Dışarıdan nesne oluşturmayı engelle
    
    private let geminiAPIKey = "AIzaSyDHTswaAkQYUldi5PhxSB3zRP_rlAKjHI8"
    private let geminiURL = "https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateText"
    
    func yorumlaIcindekilerGemini(icerik: String, completion: @escaping (String?) -> Void) {
        let url = "\(geminiURL)?key=\(geminiAPIKey)"
        
        let parameters: [String: Any] = [
            "prompt": [
                "text": "Bu içindekiler listesi hakkında yorum yap: \(icerik)"
            ]
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: GeminiResponse.self) { response in
                switch response.result {
                case .success(let decodedResponse):
                    let yorum = decodedResponse.candidates.first?.content.parts.first?.text
                    completion(yorum)
                case .failure(let error):
                    print("API Hatası: \(error.localizedDescription)")
                    completion(nil)
                }
            }
    }
}

//import GoogleGenerativeAI
//
//let config = GenerationConfig(
//  temperature: 1,
//  topP: 0.95,
//  topK: 40,
//  maxOutputTokens: 8192,
//  responseMIMEType: "text/plain"
//)
//
//// Don't check your API key into source control!
//guard let apiKey = ProcessInfo.processInfo.environment["AIzaSyDHTswaAkQYUldi5PhxSB3zRP_rlAKjHI8"] else {
//  fatalError("Add GEMINI_API_KEY as an Environment Variable in your app's scheme.")
//}
//
//let model = GenerativeModel(
//  name: "gemini-2.0-flash",
//  apiKey: apiKey,
//  generationConfig: config
//)
//
//let chat = model.startChat(history: [
//
//])
//
//Task {
//  do {
//    let message = "INSERT_INPUT_HERE"
//    let response = try await chat.sendMessage(message)
//    print(response.text ?? "No response received")
//  } catch {
//    print(error)
//  }
//}
