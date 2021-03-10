//
//  GithubAPI.swift
//  TaskMVC
//
//  Created by sakiyamaK on 2021/03/10.
//

import Foundation

/*
 模範解答
 */

// エラーを定義している
enum GithubError: Error {
  case error
}

// APIを呼び出すためのクラスを用意している
final class GithubAPI {
  static let shared = GithubAPI()

  private init() {}

  func get(searchWord: String, completion: ((Result<[GithubModel], GithubError>) -> Void)? = nil) {
    guard searchWord.count > 0 else {
      completion?(.failure(.error))
      return
    }
    let url: URL = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)&sort=stars")!
    let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
      // Codableを使ってパースしている
      guard let data = data,
            let githubResponse = try? JSONDecoder().decode(GithubResponse.self, from: data),
            let models = githubResponse.items else {
        completion?(.failure(.error))
        return
      }
      completion?(.success(models))
    })
    task.resume()
  }
}
