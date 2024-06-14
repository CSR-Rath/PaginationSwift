//
//  Cell.swift
//  PaginationSwiftUIkit
//
//  Created by Rath! on 14/6/24.
//

import UIKit

class Cell: UITableViewCell {
    
    let title = UILabel()
    let imgLogo = UIImageView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstrain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupConstrain(){
        
        imgLogo.contentMode = .scaleAspectFill
        addSubview(imgLogo)
        imgLogo.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            imgLogo.heightAnchor.constraint(equalToConstant: 50),
            imgLogo.widthAnchor.constraint(equalToConstant: 50),
            imgLogo.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            imgLogo.bottomAnchor.constraint(equalTo:bottomAnchor,constant: -10),
            imgLogo.topAnchor.constraint(equalTo:topAnchor,constant: 10),
            
            title.leftAnchor.constraint(equalTo: imgLogo.rightAnchor, constant: 10),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
        
        ])
    }
}
