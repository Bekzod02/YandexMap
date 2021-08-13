//
//  PopUpBottomController.swift
//  YandexDemo
//
//  Created by sabgames on 03.08.2021.
//



import UIKit
import YandexMapsMobile


class PopUpBottomController: BottomPopupViewController  {
    
    var searchManager = SearchManager()
    var delegate: SearchDelegate?
    var searchResultString: String? = ""
    
    private var collectionView: UICollectionView?

    var searchModules: [SearchModule]? {
        didSet {
            OperationQueue.main.addOperation {
                self.collectionView?.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        //layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height / 10)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        
        let popupSearchBur = UISearchBar()
        popupSearchBur.searchBarStyle = .minimal
        popupSearchBur.backgroundColor = .white
        popupSearchBur.placeholder = "Search"
        popupSearchBur.layer.cornerRadius = 20
        popupSearchBur.layer.masksToBounds = true
        popupSearchBur.delegate = self
        view.addSubview(popupSearchBur)
        popupSearchBur.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraintsWithFormat("V:|-18-[v0(50)]", views: popupSearchBur)
        view.addConstraintsWithFormat("H:|-20-[v0]-20-|", views: popupSearchBur)
        
        
        
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.topAnchor.constraint(equalTo: popupSearchBur.bottomAnchor, constant: 10).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.register(PopupCollectionViewCell.self, forCellWithReuseIdentifier: PopupCollectionViewCell.identifier)
    }
    

    
    override func getPopupTopCornerRadius() -> CGFloat {
        return 12
    }
    
    override func getPopupHeight() -> CGFloat {
        
        let height = UIScreen.main.bounds.height - 70
        return height    }
}


extension PopUpBottomController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private func filterAndModifyTextAttributes(searchStringCharacters: String, completeStringWithAttributedText: String) -> NSMutableAttributedString {

        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: completeStringWithAttributedText)
        let pattern = searchStringCharacters.lowercased()
        let range: NSRange = NSMakeRange(0, completeStringWithAttributedText.count)
        var regex = NSRegularExpression()
        do {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options())
            regex.enumerateMatches(in: completeStringWithAttributedText.lowercased(), options: NSRegularExpression.MatchingOptions(), range: range) {
                (textCheckingResult, matchingFlags, stop) in
                let subRange = textCheckingResult?.range
                let attributes : [NSAttributedString.Key : Any] = [.font : UIFont.boldSystemFont(ofSize: 16),.foregroundColor: UIColor.black ]
                attributedString.addAttributes(attributes, range: subRange!)
            }
        }catch{
            print(error.localizedDescription)
        }
        return attributedString
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchModules?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopupCollectionViewCell.identifier, for: indexPath) as! PopupCollectionViewCell
        cell.locationLabel.attributedText = self.filterAndModifyTextAttributes(searchStringCharacters: self.searchResultString ?? "", completeStringWithAttributedText: (searchModules?[indexPath.item].locationAdress!)!)
        cell.searchModule = searchModules?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let descrip = searchModules?[indexPath.item].locationDescription {
            let approximateWidthOfLabels = view.frame.width - 23 - 24 - 26 - 2
            let size = CGSize(width: approximateWidthOfLabels, height: 1000)
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let estimatedFrame = NSString(string: descrip).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 59)
        }
        if let adress = searchModules?[indexPath.item].locationAdress {
            let approximateWidthOfLabels = view.frame.width - 23 - 24 - 26 - 2
            let size = CGSize(width: approximateWidthOfLabels, height: 1000)
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
            let estimatedFrame = NSString(string: adress).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 59)
        }
        return CGSize(width: view.frame.size.width, height: view.frame.size.height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
        collectionView.deselectItem(at: indexPath, animated: true)
        let latDouble = Double((searchModules?[indexPath.item].lat)!)
        let lonDouble = Double((searchModules?[indexPath.item].lon)!)
        delegate?.searchAndMove(langitude: latDouble!, longitude: lonDouble!)
        dismiss(animated: true, completion: nil)
        collectionView.reloadData()
    }

}

extension PopUpBottomController: UISearchBarDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResultString = searchBar.text
        if searchText == "" {
            searchModules = [SearchModule]()
            collectionView?.reloadData()
        } else if searchBar.text!.count > 2 {
            if let location = searchBar.text {
                searchManager.fetchLocation(locationName: location) { searchResult in
                    DispatchQueue.main.async {
                        self.searchModules = searchResult
                        self.collectionView?.reloadData()
                    }
                }
            }
            
        }
        
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        view.endEditing(true)
        collectionView?.reloadData()
    }
 
}





