//
//  ViewController.swift
//  Demo_ScrollDir_Hori_Section_Continuous
//
//  Created by 蔡忠翊 on 2021/9/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = generateLayout()
        collectionView.isPagingEnabled = true
    }
    
    /* 水平捲動的分頁，分頁的內容垂直捲動 */
    // 將 configuration.scrollDirection 設成 horizontal，collectionView 的 isPagingEnabled 設成 true，實現水平滑動的分頁，section.orthogonalScrollingBehavior 設成 continuous 讓分頁的內容垂直捲動
    
    func generateLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        return UICollectionViewCompositionalLayout(sectionProvider: { section, environment in
            let space: Double = 10
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: section == 0 ? 2 : 3)
            group.interItemSpacing = .fixed(space)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = space
            section.contentInsets = NSDirectionalEdgeInsets(top: space, leading: space, bottom: space, trailing: space)
            section.orthogonalScrollingBehavior = .continuous
            return section
            
        }, configuration: configuration)
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionViewCell.self)", for: indexPath) as! CollectionViewCell
        cell.imageView.image = UIImage(named: "Image\(indexPath.item + 1)")
        cell.label.text = "Image\(indexPath.item + 1)"
        return cell
    }
}
