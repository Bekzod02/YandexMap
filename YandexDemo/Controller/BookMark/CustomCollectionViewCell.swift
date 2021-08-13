//
//  CustomCollectionViewCell.swift
//  YandexDemo
//
//  Created by sabgames on 04.08.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    private let cellView: UIView = {
        let cellView = UIView()
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = 25
        return cellView
    }()

    private let myImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = UIImage(named: "Fav_Icon")
        myImageView.contentMode = .scaleAspectFit
        return myImageView
    }()
    
    private let upLabel: UILabel = {
        let upLabel = UILabel()
        upLabel.text = "Государственный музей искусств Узбекистана"
        upLabel.font = UIFont.boldSystemFont(ofSize: 18)
        upLabel.numberOfLines  = 0
        return upLabel
    }()
    private let bottomLabel: UILabel = {
        let bottomLabel = UILabel()
        bottomLabel.text = "Ташкент, Узбекстан"
        bottomLabel.font = bottomLabel.font.withSize(14)
        bottomLabel.textColor = .lightGray
        bottomLabel.numberOfLines = 0
        return bottomLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //contentView.backgroundColor = UIColor.init(white: 1, alpha: 0.7)
        contentView.layer.cornerRadius = 25
        contentView.addSubview(cellView)
        contentView.addSubview(myImageView)
        contentView.addSubview(upLabel)
        contentView.addSubview(bottomLabel)
        
        addConstraintsWithFormat("H:|-0-[v0]-0-|", views: cellView)
        addConstraintsWithFormat("V:|-0-[v0]-0-|", views: cellView)
        addConstraintsWithFormat("H:|-16-[v0]-30-[v1]", views: upLabel, myImageView)
        addConstraintsWithFormat("H:[v0]-20-|", views: myImageView)
        addConstraintsWithFormat("V:|-16-[v0]-0-[v1]|", views: upLabel, bottomLabel)
        addConstraintsWithFormat("V:[v0(80)]|", views: bottomLabel)
        addConstraintsWithFormat("H:|-21-[v0]-80-|", views: bottomLabel)
        addConstraintsWithFormat("V:|-40-[v0]-70-|", views: myImageView)
        //addConstraintsWithFormat("H:[v0]-20-|", views: myImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}




















