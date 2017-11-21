//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Trần Vũ Hưng on 11/21/17.
//  Copyright © 2017 Tran Vu Hung. All rights reserved.
//

import UIKit
import Messages

protocol Chocoholicable {
    func setChocoholic(_ chocoholic: Bool)
}

class MessagesViewController: MSMessagesAppViewController {

    @IBAction func handleChocoholicChanged(_ sender: UISwitch) {
        childViewControllers.forEach { (vc) in
            guard let vc = vc as? Chocoholicable else {return}
            vc.setChocoholic(sender.isOn)
        }
    }
}
