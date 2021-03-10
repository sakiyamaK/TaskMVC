//
//  WebViewController.swift
//  TaskMVC
//
//  Created by  on 2021/3/10.
//

import UIKit
import WebKit

/*
 模範解答
 */
final class WebViewController: UIViewController {

  //パラメータをカプセル化している
  @IBOutlet private weak var webView: WKWebView!

  private var githubModel: GithubModel?

  //外部からはモデルだけを受け取っている
  func configure(githubModel: GithubModel) {
    self.githubModel = githubModel
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    //初期化パラメータが不正ならguardで弾いている
    guard
      let githubModel = githubModel,
      let url = URL(string: githubModel.urlStr) else {
      return
    }
    webView.load(URLRequest(url: url))
  }
}
