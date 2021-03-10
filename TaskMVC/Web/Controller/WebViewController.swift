//
//  WebViewController.swift
//  TaskMVC
//
//  Created by  on 2021/3/10.
//

import UIKit
import WebKit

/*
 カプセル化されてません
 前の画面からModelを受け取っていません
 強制アンラップがあります
 */
final class WebViewController: UIViewController {

  @IBOutlet weak var webView: WKWebView!

  var urlStr: String?

  override func viewDidLoad() {
    super.viewDidLoad()

    let url = URL(string: urlStr!)!
    let request = URLRequest(url: url)
    webView.load(request)
  }
}
