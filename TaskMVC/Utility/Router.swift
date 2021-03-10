//
//  Router.swift
//  TaskMVC
//
//  Created by sakiyamaK on 2021/03/10.
//

import UIKit

/*
 模範解答
 */

final class Router {
  static let shared = Router()
  private init() {}

  private var window: UIWindow?

  func showRoot(window: UIWindow) {
    //もうStoryboardのファイルはここからしか呼ばないからハードコーディングでも問題ない
    guard let vc = UIStoryboard.init(name: "MVCSearch", bundle: nil).instantiateInitialViewController() else {
      return
    }
    let nav = UINavigationController(rootViewController: vc)
    window.rootViewController = nav
    window.makeKeyAndVisible()
    self.window = window
  }

  func showWeb(from: UIViewController, githubModel: GithubModel) {
    guard let web = UIStoryboard.init(name: "Web", bundle: nil).instantiateInitialViewController() as? WebViewController else {
      return
    }
    web.configure(githubModel: githubModel)
    show(from: from, to: web)
  }

  private func show(from: UIViewController, to: UIViewController, completion:(() -> Void)? = nil){
    if let nav = from.navigationController {
      nav.pushViewController(to, animated: true)
      completion?()
    } else {
      from.present(to, animated: true, completion: completion)
    }
  }
}
