 //
//  Layouts.swift
//  Make-ChatRooms-StarterKit
//
//  Created by Matthew Harrilal on 2/18/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit
 
//
// extension ChatRoomViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loadViews() // Layout for how the messages and c hat interface should look!
//    }
//
//    // In charge of dismissing the keyboard and laying out views after
//    func keyboardWillChange(notification: NSNotification) {
//        if let userInfo = notification.userInfo {
//            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)!.cgRectValue
//            let messageBarHeight = self.messageInputBar.bounds.size.height
//            let point = CGPoint(x: self.messageInputBar.center.x, y: endFrame.origin.y - messageBarHeight/2.0)
//            let inset = UIEdgeInsets(top: 0, left: 0, bottom: endFrame.size.height, right: 0)
//            UIView.animate(withDuration: 0.25) {
//                self.messageInputBar.center = point
//                self.tableView.contentInset = inset
//            }
//        }
//    }
//
//    // Upon view did loading configure views to be connected and added as subviews
//    func loadViews() {
//        navigationItem.backBarButtonItem?.title = "Run!"
//
//        view.backgroundColor = UIColor(red: 24/255, green: 180/255, blue: 128/255, alpha: 1.0)
//
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.separatorStyle = .none
//
//        view.addSubview(tableView)
//        view.addSubview(messageInputBar)
//
//        messageInputBar.delegate = self
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        let messageBarHeight:CGFloat = 60.0
//        let size = view.bounds.size
//        tableView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height - messageBarHeight)
//        messageInputBar.frame = CGRect(x: 0, y: size.height - messageBarHeight, width: size.width, height: messageBarHeight)
//    }
// }
//
