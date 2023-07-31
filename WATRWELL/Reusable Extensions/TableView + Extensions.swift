//
//  TableView + Extensions.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 29/07/23.
//

import UIKit

extension UITableView {
    
    func registerCell(with identifier: UITableViewCell.Type)  {
        self.register(UINib(nibName: "\(identifier.self)", bundle: nil), forCellReuseIdentifier: "\(identifier.self)")
    }
    
    func dequeueCell <T: UITableViewCell> (with identifier: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: "\(identifier.self)", for: indexPath) as! T
    }
    
    func hasRowAtIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}

extension UICollectionView {
    
    func registerCell(with identifier: UICollectionViewCell.Type)  {
        self.register(UINib(nibName: "\(identifier.self)", bundle: nil), forCellWithReuseIdentifier: "\(identifier.self)")
    }
    
    func dequeueCell <T: UICollectionViewCell> (with identifier: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: "\(identifier.self)", for: indexPath) as! T
    }
}
