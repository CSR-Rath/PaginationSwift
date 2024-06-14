//
//  UITableView + Extension.swift
//  PaginationSwiftUIkit
//
//  Created by Rath! on 14/6/24.
//

import Foundation
import UIKit

extension UITableView{
    
     func showLoadingSpinner(with title: String = "Fetch data.") {
        // Add a loading spinner and title to the table view
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()

        let titleLabel = UILabel()
        titleLabel.text = title
         titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        titleLabel.textColor = .red
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.sizeToFit()
        titleLabel.textAlignment = .center
//        titleLabel.backgroundColor = .orange

        let stackView = UIStackView(arrangedSubviews: [spinner, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8

        let containerView = UIView(frame: CGRect(x: 0, y: 0,
                                                 width: self.bounds.width,
                                                 height: titleLabel.frame.height + spinner.frame.height + 16))
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
         
         
         self.tableFooterView = containerView
    }
    
     func hideLoadingSpinner() {
        // Remove the loading spinner from the table view
        self.tableFooterView = nil
    }
}
