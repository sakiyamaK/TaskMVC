//
//  AppDelegate.swift
//  TaskMVC
//
//  Created by sakiyamaK on 2021/03/10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = UIStoryboard.init(name: "MVC", bundle: nil).instantiateInitialViewController()
    window.makeKeyAndVisible()
    self.window = window
    return true
  }
}

