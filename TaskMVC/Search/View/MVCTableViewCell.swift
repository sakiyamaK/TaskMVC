//
//  MVCTableViewCell.swift
//  TaskMVC
//
//  Created by sakiyamaK on 2021/03/10.
//

import UIKit

/*
 模範解答
 */
final class MVCTableViewCell: UITableViewCell {

  static var className: String { String(describing: MVCTableViewCell.self) }

  //パラメータをカプセル化している
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var urlLabel: UILabel!

  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = nil
    urlLabel.text = nil
  }

  //外部から必要なモデルだけ受け取りその情報で自身のパーツを更新している
  func configure(githubModel: GithubModel) {
    self.titleLabel.text = githubModel.fullName
    self.urlLabel.text = githubModel.urlStr
  }
}

