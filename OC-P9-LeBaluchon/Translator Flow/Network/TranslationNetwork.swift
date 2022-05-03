// TranslationNetwork.swift
// OC-P9-LeBaluchon
// Created by Ad Piscinam on 27/04/2022
// 

import Foundation


protocol TranslationNetworkType {
    func getData(text: String, callback: @escaping (Result<TranslateTextResponseTranslation, Error>) -> Void)
}

final class TranslationNetwork: TranslationNetworkType {
    var apiAdresse = "https://translation.googleapis.com/language/translate/v2?"
    var question = "q="
    var textToTranslate = ""
    var languageTarget = "&target="
    var languageTargetCode = "en"
    var format = "&format=text"
    var languageSource = "&source="
    var languageSourceCode = ""
    var apiKey = "&key="
    var keyValue = "AIzaSyB3SW8oNYlcdvlHKlzsj9vKhgufBAalj3Y"
    
    private let session: URLSession
    private var task: URLSessionDataTask?
    
    init() {
        session = URLSession.init(configuration: .default)
    }
    
    private func constructApiCall(textToTranslate: String, targetCode: String, sourceCode: String) -> String {
        apiAdresse + question + textToTranslate + languageTarget + targetCode + format + languageSource + sourceCode + apiKey + keyValue
    }
    
    func getData(text: String, callback: @escaping (Result<TranslateTextResponseTranslation, Error>) -> Void) {
        let stringURL = constructApiCall(textToTranslate: text, targetCode: languageTargetCode, sourceCode: languageSourceCode)
        
        guard let url = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        guard let strigedUrl = URL(string: url) else { return }
        
        task = session.dataTask(with: strigedUrl, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                guard let data = data , error == nil else {
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 || response.statusCode == 404 else {
                    return
                }
                
                var result: TranslateTextResponseTranslation?
                
                do {
                    result = try JSONDecoder().decode(TranslateTextResponseTranslation.self, from: data)
                } catch let error {
                    callback(.failure(error))
                }
                guard let json = result else {
                    return
                }
                callback(.success(json))
            }
        })
        task?.resume()
    }
}
