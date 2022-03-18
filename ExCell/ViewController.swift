//
//  ViewController.swift
//  ExCell
//
//  Created by Jake.K on 2022/03/17.
//

import UIKit

class ViewController: UIViewController {
  private let tableView: UITableView = {
    let view = UITableView()
    view.allowsSelection = true
    view.backgroundColor = .clear
    view.separatorStyle = .none
    view.bounces = true
    view.showsVerticalScrollIndicator = true
    view.clipsToBounds = false
    view.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.id)
    view.estimatedRowHeight = 34
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentInset = .init(top: 0, left: 50, bottom: 0, right: 0)
    return view
  }()
  private lazy var nextButton: UIButton = {
    let button = UIButton()
    button.setTitle("Next", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.setTitleColor(.blue, for: .highlighted)
    button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(button)
    return button
  }()
  
  private let dataSource = (0...55).map(String.init(_:))

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(self.tableView)
    self.view.addSubview(self.nextButton)
    NSLayoutConstraint.activate([
      self.tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
      self.tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
      self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
      
      self.nextButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
      self.nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    ])
    self.tableView.dataSource = self
  }
  @objc func didTapNextButton() {
    let vc2 = VC2()
    vc2.modalPresentationStyle = .fullScreen
    self.present(vc2, animated: true)
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.dataSource.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.id) as! MyTableViewCell
    cell.prepare(titleText: self.dataSource[indexPath.row])
    return cell
  }
}

final class MyTableViewCell: UITableViewCell {
  static let id = "MyTableViewCell"

  // MARK: UI
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "테스트"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  // MARK: Initializer
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.selectionStyle = .none
    
    self.contentView.addSubview(self.titleLabel)
    NSLayoutConstraint.activate([
      self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
      self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
    ])
  }
  
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)
    self.backgroundColor = highlighted ? .systemBlue : .white
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.prepare(titleText: nil)
  }
  
  func prepare(titleText: String?) {
    self.titleLabel.text = titleText
  }
}

