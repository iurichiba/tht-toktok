//
//  FeedTableView.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 05/12/22.
//

import UIKit

class FeedTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupView()
        setupCells()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupCells()
    }
    
    private func setupView() {
        self.backgroundColor = .black
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
        self.isPagingEnabled = true // snapping behaviour
    }
    
    private func setupCells() {
        let cellIdentifier = String(describing: FeedCell.self)
        self.register(UINib(nibName: cellIdentifier, bundle: nil),
                      forCellReuseIdentifier: cellIdentifier)
    }
    
}
