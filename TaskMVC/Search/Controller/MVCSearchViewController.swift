//
//  MVCViewController.swift
//  TaskMVC
//
//  Created by  on 2021/3/10.
//

import UIKit

/*
 模範解答
*/
final class MVCSearchViewController: UIViewController {

  //パラメータを全てprivateにしてカプセル化している
  @IBOutlet private weak var searchTextField: UITextField!
  @IBOutlet private weak var searchButton: UIButton! {
    didSet {
      searchButton.addTarget(self, action: #selector(tapSearchButton(_sender:)), for: .touchUpInside)
    }
  }

  @IBOutlet private weak var indicator: UIActivityIndicatorView!

  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.register(UINib.init(nibName: MVCTableViewCell.className, bundle: nil), forCellReuseIdentifier: MVCTableViewCell.className)
      tableView.delegate = self
      tableView.dataSource = self
    }
  }

  //APIから取得したデータはモデル化している
  private var items: [GithubModel] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.isHidden = true
    indicator.isHidden = true
  }

  @objc func tapSearchButton(_sender: UIResponder) {
    guard let searchWord = searchTextField.text, !searchWord.isEmpty else { return }
    indicator.isHidden = false
    tableView.isHidden = true
    //データの取得を別クラスに任せている
    //サーバーからアクセスしていることもControllerは知る必要がない
    GithubAPI.shared.get(searchWord: searchWord) { result in
      DispatchQueue.main.async {
        self.indicator.isHidden = true
        self.tableView.isHidden = false
        switch result {
        case .failure(let error):
          print(error)
        case .success(let items):
          self.items = items
          self.tableView.reloadData()
        }
      }
    }
  }
}

extension MVCSearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    //画面遷移を別クラスにまとめている
    Router.shared.showWeb(from: self, githubModel: items[indexPath.item])
  }
}

extension MVCSearchViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MVCTableViewCell.className) as? MVCTableViewCell else {
      fatalError()
    }
    let githubModel = items[indexPath.item]
    //Viewがカプセル化されモデルだけ渡している
    cell.configure(githubModel: githubModel)
    return cell
  }
}
