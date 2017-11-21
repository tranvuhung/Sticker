//
//  StickerCollectionViewController.swift
//  Sticker
//
//  Created by Trần Vũ Hưng on 11/21/17.
//  Copyright © 2017 Tran Vu Hung. All rights reserved.
//

import UIKit
import Messages

let stickerNameGroups: [String: [String]] = [
    "Crunchy": ["CandyCane","JawBreaker","Lollipop"],
    "Chewy": ["Caramel","GummiBear","SourCandy"],
    "Chocolate": ["ChocolateBar","ChocolateChip","DarkChocolate"]
]

struct StickerGroup{
    let name: String
    let members: [MSSticker]
}

class StickerCollectionViewController: UICollectionViewController {
    var stickerGroups = [StickerGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStickers()
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
        collectionView?.backgroundColor = #colorLiteral(
            red: 0.9490196078, green: 0.7568627451,
            blue: 0.8196078431, alpha: 1)
    }
}

extension StickerCollectionViewController {
    func loadStickers(_ chocoholic: Bool = false){
        stickerGroups = stickerNameGroups.filter({ (name, _) in
            return chocoholic ? name == "Chocolate" : true
        }).map({ (name, stickerName) in
            let stickers: [MSSticker] = stickerName.map({ (name) in
                let url = Bundle.main.url(forResource: name, withExtension: "png")!
                return try! MSSticker(contentsOfFileURL: url, localizedDescription: name)
            })
            return StickerGroup(name: name, members: stickers)
        })
        stickerGroups.sort(by: {$0.name < $1.name})
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension StickerCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let edge = min(collectionView.bounds.size.width / 3, 136)
        return CGSize(width: edge, height: edge)
    }
}
//MARK: UICollectionViewDataSource
extension StickerCollectionViewController{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return stickerGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickerGroups[section].members.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StickerCollectionViewCell", for: indexPath) as! StickerCollectionViewCell
        let sticker = stickerGroups[indexPath.section].members[indexPath.row]
        cell.stickerView.sticker = sticker
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionElementKindSectionHeader else { fatalError() }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
        header.label.text = stickerGroups[indexPath.section].name
        return header
    }
}

//MARK: Pro Chocoholic
extension StickerCollectionViewController: Chocoholicable {
    func setChocoholic(_ chocoholic: Bool) {
        loadStickers(chocoholic)
        collectionView?.reloadData()
    }
}
