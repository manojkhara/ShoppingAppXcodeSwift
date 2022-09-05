//
//  categoryCollectionViewCell.swift
//  myShopTask
//
//  Created by Manoj 07 on 29/08/22.
//

import UIKit

class categoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "categoryCollectionViewCell"

    let categoryImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_add_img")
        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
        
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textAlignment = .center
        return label
    }()
    
    let button : UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
        
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        categoryImageView.frame = CGRect(x: 10, y: 0, width: contentView.frame.width-20, height: contentView.frame.width-40)
        
        nameLabel.frame = CGRect(x: 0, y: contentView.frame.width-40, width: 0.6 * contentView.frame.width, height: 30)
        
        button.frame = CGRect(x: 0.6 * contentView.frame.width , y: contentView.frame.width-38, width: 0.4 * contentView.frame.width, height: 28)
        
        contentView.addSubview(categoryImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(button)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

