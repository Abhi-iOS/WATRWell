//
//  WWDropDownView.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import Foundation
import UIKit

class CustomDropdownView: UIView {
    private let tableView = UITableView()
    private var options = [String]()

    var didSelectOption: ((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        tableView.dataSource = self
        tableView.delegate = self
        addSubview(tableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
    }

    func setOptions(_ options: [String]) {
        self.options = options
        tableView.reloadData()
    }
}

extension CustomDropdownView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WWBaseTVC(style: .default, reuseIdentifier: "DropDownCell")
        cell.backgroundColor = .black
        cell.contentView.backgroundColor = .black
        cell.textLabel?.text = "○ " + options[indexPath.row]
        cell.textLabel?.textColor = .white
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = options[indexPath.row]
        didSelectOption?(selectedOption)
    }
}
