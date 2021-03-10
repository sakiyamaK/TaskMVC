//
//  GithubModel.swift
//  TaskMVC
//
//  Created by sakiyamaK on 2021/03/10.
//

import Foundation

/*
 模範解答
 */

//APIのレスポンスをCodableで受け取れるようにしている
struct GithubResponse: Codable {
  let items: [GithubModel]?
}

//Modelファイルを用意している
struct GithubModel: Codable {
  let fullName: String
  var urlStr: String { "https://github.com/\(fullName)" }

  enum CodingKeys: String, CodingKey {
    case fullName = "full_name"
  }
}
