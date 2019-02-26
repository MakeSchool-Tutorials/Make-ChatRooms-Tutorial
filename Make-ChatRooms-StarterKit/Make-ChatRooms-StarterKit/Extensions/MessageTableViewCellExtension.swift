//
//  MessageTableViewCellExtension.swift
//  Make-ChatRooms-StarterKit
//
//  Created by Matthew Harrilal on 2/25/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

// extension MessageTableViewCell {
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        if isJoinMessage() {
//            layoutForJoinMessage()
//
//        } else {
//            // Configuration of the UI message elements
//            messageContentLabel.font = UIFont(name: "Proxima Nova", size: 17)
//            messageContentLabel.textColor = .white
//
//            let size = messageContentLabel.sizeThatFits(CGSize(width: 2*(bounds.size.width/3), height: CGFloat.greatestFiniteMagnitude))
//            messageContentLabel.frame = CGRect(x: 0, y: 0, width: size.width + 32, height: size.height + 16)
//
//
//            // If the user is the one who initiated the message that is being sent currently
//
//           // Depending on the message sender configure message bubble to be either green or gray
//            if self.message?.messageSender == true {
//                nameLabel.isHidden = true
//
//                messageContentLabel.center = CGPoint(x: bounds.size.width - messageContentLabel.bounds.size.width/2.0 - 16, y: bounds.size.height/2.0)
//                messageContentLabel.backgroundColor = UIColor(red: 24/255, green: 180/255, blue: 128/255, alpha: 1.0)
//            } else {
//                nameLabel.isHidden = false
//                nameLabel.sizeToFit()
//                nameLabel.center = CGPoint(x: nameLabel.bounds.size.width/2.0 + 16 + 4, y: nameLabel.bounds.size.height/2.0 + 4)
//
//                messageContentLabel.center = CGPoint(x: messageContentLabel.bounds.size.width/2.0 + 16, y: messageContentLabel.bounds.size.height/2.0 + nameLabel.bounds.size.height + 8)
//                messageContentLabel.backgroundColor = .lightGray
//            }
//
//        }
//
//        messageContentLabel.layer.cornerRadius = min(messageContentLabel.bounds.size.height/2.0, 20)
//    }
//
//    func layoutForJoinMessage() {
//        messageContentLabel.font = UIFont.systemFont(ofSize: 10)
//        messageContentLabel.textColor = .lightGray
//        messageContentLabel.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
//
//        let size = messageContentLabel.sizeThatFits(CGSize(width: 2*(bounds.size.width/3), height: CGFloat.greatestFiniteMagnitude))
//        messageContentLabel.frame = CGRect(x: 0, y: 0, width: size.width + 32, height: size.height + 16)
//        messageContentLabel.center = CGPoint(x: bounds.size.width/2, y: bounds.size.height/2.0)
//    }
//
//    func isJoinMessage() -> Bool {
//        if let words = messageContentLabel.text?.components(separatedBy: " ") {
//            if words.count >= 2 && words[words.count - 2] == "has" && words[words.count - 1] == "joined" {
//                return true
//            }
//        }
//
//        return false
//    }
// }



