//
//  CandyStickerBrowserViewController.swift
//  Sticker
//
//  Created by Trần Vũ Hưng on 11/21/17.
//  Copyright © 2017 Tran Vu Hung. All rights reserved.
//

import Messages

let stickerNames = ["CandyCane", "Caramel", "ChocolateBar",
                    "ChocolateChip", "DarkChocolate", "GummiBear",
                    "JawBreaker", "Lollipop", "SourCandy"]

class CandyStickerBrowserViewController: MSStickerBrowserViewController {
    var stickers = [MSSticker]()
    
    override func viewDidLoad() {
        loadStickers()
        stickerBrowserView.backgroundColor = #colorLiteral(
            red: 0.9490196078, green: 0.7568627451,
            blue: 0.8196078431, alpha: 1)
    }
    
    //MARK: - MSStickerBrowserViewDataSource
    override func numberOfStickers(in stickerBrowserView: MSStickerBrowserView) -> Int {
        return stickers.count
    }
    
    override func stickerBrowserView(_ stickerBrowserView: MSStickerBrowserView, stickerAt index: Int) -> MSSticker {
        return stickers[index]
    }
}

extension CandyStickerBrowserViewController {
    func loadStickers(){
        stickers = stickerNames.map({ (name) in
            let url = Bundle.main.url(forResource: name, withExtension: "png")!
            return try! MSSticker(contentsOfFileURL: url, localizedDescription: name)
        })
    }
}
