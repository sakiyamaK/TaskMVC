//
//  MVCViewController.swift
//  TaskMVC
//
//  Created by  on 2021/3/10.
//

import UIKit

/*
 Modelがありません
 データを取得するソースがコントローラに書かれています
 強制アンラップがあります
 パラメータがカプセル化されていません
 次の画面にモデルを渡していません
 画面遷移の処理が直接ViewControllerに書かれています
 修正してMVCにしてください
*/
final class MVCSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var searchButton: UIButton! {
    didSet {
      searchButton.addTarget(self, action: #selector(tapSearchButton(_sender:)), for: .touchUpInside)
    }
  }

  @IBOutlet weak var indicator: UIActivityIndicatorView!

  @IBOutlet weak var tavleView: UITableView! {
    didSet {
      tavleView.register(UINib.init(nibName: MVCTableViewCell.className, bundle: nil), forCellReuseIdentifier: MVCTableViewCell.className)
      tavleView.delegate = self
      tavleView.dataSource = self
    }
  }

  var items: [(title: String, urlStr: String)] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    tavleView.isHidden = true
    indicator.isHidden = true
  }

  @objc func tapSearchButton(_sender: UIResponder) {
    indicator.isHidden = false
    tavleView.isHidden = true
    let url: URL = URL(string: "https://api.github.com/search/repositories?q=\(searchTextField.text!)&sort=stars")!
    let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

      guard let dic = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any],
            let responseItems = dic["items"] as? [[String: Any]]
            else {
        return
      }

      self.items = responseItems.map({ (item) -> (String, String) in
        let fullName = item["full_name"] as! String
        return (fullName, "https://github.com/\(fullName)")
      })

      DispatchQueue.main.async {
        self.indicator.isHidden = true
        self.tavleView.isHidden = false
        self.tavleView.reloadData()
      }
    })
    task.resume()
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let vc = UIStoryboard.init(name: "Web", bundle: nil).instantiateInitialViewController() as! WebViewController
    vc.urlStr = items[indexPath.item].urlStr

    let nav = self.navigationController
    nav?.pushViewController(vc, animated: true)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MVCTableViewCell.className) as? MVCTableViewCell else {
      fatalError()
    }
    cell.titleLabel.text = items[indexPath.item].title
    cell.urlLabel.text = items[indexPath.item].urlStr
    return cell

  }
}
