//
//  MVCTableViewCell.swift
//  TaskMVC
//
//  Created by sakiyamaK on 2021/03/10.
//

import UIKit

/*
 viewのカプセル化ができていません
 カプセル化させてModelを受け取ってデータを更新させるように改修してください

 */
final class MVCTableViewCell: UITableViewCell {

  static var className: String { String(describing: MVCTableViewCell.self) }

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var urlLabel: UILabel!

  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = nil
    urlLabel.text = nil
  }
}

