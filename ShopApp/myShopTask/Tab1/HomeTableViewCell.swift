//
//  customTableViewCell.swift
//  myShopTask
//
//  Created by Manoj 07 on 27/08/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    static let identifier = "HomeTableViewCell"
        
    let productImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_add_img")
        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textAlignment = .center
        return label
    }()
    
    let categoryLabel : UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.textAlignment = .center
        return label
    }()
    let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.textAlignment = .center
        return label
    }()

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        productImageView.frame = CGRect(x: 10, y: 10, width: contentView.frame.width-20, height: 200)
        
        nameLabel.frame = CGRect(x:0, y: 200, width: contentView.frame.width/2 , height: 40)

        
        priceLabel.frame = CGRect(x: contentView.frame.width/2, y: 200, width: contentView.frame.width/2, height: 40)

        
        categoryLabel.frame = CGRect(x: 0, y: 240, width: contentView.frame.width/2, height: 40)


        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(priceLabel)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
