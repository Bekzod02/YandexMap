//
//  PopupTableViewCell.swift
//  YandexDemo
//
//  Created by sabgames on 03.08.2021.
//

import UIKit

class PopupCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "customTableViewCell"
    var searchModule: SearchModule? {
        didSet {
            //locationLabel.text = searchModule?.locationAdress
            descriptionLabel.text = searchModule?.locationDescription
        }
    }
    
     
    private let seperatorView: UIView = {
        let seperatorView = UIView()
        seperatorView.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.94, alpha: 1)
        return seperatorView
    }()
    private let searchBarTopView: UIView = {
        let searchBarTopView = UIView()
        searchBarTopView.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.94, alpha: 1)
        return searchBarTopView
    }()
    
     let locationLabel: UILabel = {
        let locationLabel = UILabel()
        //locationLabel.textColor = UIColor.black
        locationLabel.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        locationLabel.font = UIFont(name: "Gilroy-Medium", size: 16)
        locationLabel.textAlignment = .left
        locationLabel.font = locationLabel.font.withSize(16)
        locationLabel.numberOfLines = 0
        return locationLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = UIFont(name: "Gilroy-Medium", size: 13)
        descriptionLabel.font = descriptionLabel.font.withSize(14)
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private let myImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = UIImage(named: "Location_Icon-1")
        myImageView.contentMode = .scaleAspectFill
        return myImageView
    }()
    private let distanceLabel: UILabel = {
        let distanceLabel = UILabel()
        distanceLabel.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        distanceLabel.text = "1.2km"
        distanceLabel.numberOfLines = 0
        distanceLabel.font = distanceLabel.font.withSize(12)
        return distanceLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.addSubview(locationLabel)
        contentView.addSubview(myImageView)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(seperatorView)
        contentView.addSubview(searchBarTopView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
//        addConstraintsWithFormat("H:|-25-[v0(24)]", views: myImageView)
//        addConstraintsWithFormat("V:|-30-[v0(29)]", views: myImageView)
//        addConstraintsWithFormat("H:[v0(40)]-30-|", views: distanceLabel)
//        addConstraintsWithFormat("V:|-14-[v0(25)]", views: distanceLabel)
//        addConstraintsWithFormat("H:|-70-[v0(250)]-40-|", views: locationLabel)
//        addConstraintsWithFormat("V:|-5-[v0(50)]-10-|", views: locationLabel)
//        addConstraintsWithFormat("H:|-70-[v0(250)]-40-|", views: descriptionLabel)
//        addConstraintsWithFormat("V:|-10-[v0]-[v1(40)]-10-|", views: locationLabel, descriptionLabel)
//        addConstraintsWithFormat("H:|[v0]|", views: seperatorView)
//        addConstraintsWithFormat("V:[v0(1)]|", views: seperatorView)
//        addConstraintsWithFormat("H:|[v0]|", views: searchBarTopView)
//        addConstraintsWithFormat("V:|[v0(1)]", views: searchBarTopView)
        
        addConstraintsWithFormat("H:|[v0]|", views: searchBarTopView)
        addConstraintsWithFormat("V:|[v0(1)]", views: searchBarTopView)
        addConstraintsWithFormat("H:|-23-[v0(24)]-22-[v1(250)]-50-[v2(40)]-20-|", views: myImageView, locationLabel, distanceLabel)
        addConstraintsWithFormat("V:|-28-[v0(29)]-50-|", views: myImageView)
        addConstraintsWithFormat("V:|-20-[v0(25)]-65-|", views: distanceLabel)
        addConstraintsWithFormat("H:|-69-[v0(250)]-100-|", views: descriptionLabel)
        addConstraintsWithFormat("V:|-8-[v0]-5-[v1]-12-|", views: locationLabel, descriptionLabel)
        addConstraintsWithFormat("H:|[v0]|", views: seperatorView)
        addConstraintsWithFormat("V:[v0(1)]|", views: seperatorView)
        
    }
    
}


