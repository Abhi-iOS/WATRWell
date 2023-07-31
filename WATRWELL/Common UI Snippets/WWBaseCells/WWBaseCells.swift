//
//  WWBaseCells.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 28/07/23.
//

import UIKit

//MARK: - Base TV Cell
class WWBaseTVC: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        baseCellSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func baseCellSetup() {
        selectionStyle = .none
    }

}

//MARK: - Base CV Cell
class WWBaseCVC: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
