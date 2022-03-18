//
//  VC2.swift
//  ExCell
//
//  Created by Jake.K on 2022/03/17.
//

import UIKit

final class VC2: UIViewController {
  private let flowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 8.0
    layout.minimumInteritemSpacing = 0
    return layout
  }()
  
  private lazy var collectionView: UICollectionView = {
    let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
    view.isScrollEnabled = true
    view.showsHorizontalScrollIndicator = false
    view.showsVerticalScrollIndicator = true
    view.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
    view.contentInset = .zero
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.register(MyCell.self, forCellWithReuseIdentifier: MyCell.id)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .lightGray
    view.contentInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
    return view
  }()
  
  private let dataSource = (0...55).map(String.init(_:))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    self.view.addSubview(self.collectionView)
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    NSLayoutConstraint.activate([
      self.collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
      self.collectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
      self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
    ])
  }
}

extension VC2: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    self.dataSource.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.id, for: indexPath) as! MyCell
    cell.prepare(titleText: self.dataSource[indexPath.item])
    return cell
  }
}

// self.collectionView.delegate = self
extension VC2: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    .init(width: collectionView.bounds.width - 60, height: 60)
  }
}

final class MyCell: UICollectionViewCell {
  static let id = "MyCollectionViewCell"
  
  // MARK: UI
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    self.contentView.addSubview(label)
    return label
  }()
  
  override var isHighlighted: Bool {
    didSet {
      if self.isHighlighted {
        UIView.animate(
          withDuration: 0.05,
          animations: { self.backgroundColor = .systemBlue },
          completion: { finished in
            UIView.animate(withDuration: 0.05) { self.backgroundColor = .darkGray }
          }
        )
      }
    }
  }
  
  // MARK: Initializer
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.contentView.addSubview(self.titleLabel)
    self.backgroundColor = .darkGray
    NSLayoutConstraint.activate([
      self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
      self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
    ])
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    self.prepare(titleText: nil)
  }
  
  func prepare(titleText: String?) {
    self.titleLabel.text = titleText
  }
}

