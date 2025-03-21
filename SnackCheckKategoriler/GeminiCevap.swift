//
//  GeminiCevap.swift
//  SnackCheckKategoriler
//
//  Created by ELİF ÇAĞIL on 16.03.2025.
//


struct GeminiResponse: Codable {
    struct Candidate: Codable {
        struct Content: Codable {
            let parts: [Part]
        }
        let content: Content
    }
    struct Part: Codable {
        let text: String
    }
    let candidates: [Candidate]
}
