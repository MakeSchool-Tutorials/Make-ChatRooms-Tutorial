## Sending a Message

Now that we are able to join a room on our server lets start working on the ability to message other users in that room.

Disclaimer: The node server that has been running is listening for a chat message event, the problem is that it is looking for a message object after we create our message model.

Now would be a great time to start modeling our message object!

Lets first map out attributes that our message would contain.

    1. The username of the sender
    2. The content of the message
    3. A boolean indicating whether or not we are the message sender
    4. The room that the message originated from

``` swift

class Message {
    let messageContent: String
    let senderUsername: String
    var messageSender: Bool?
    var roomOriginName: String
    
    init(messageContent: String, senderUsername: String, messageSender: Bool?, roomOriginName: String) {
        self.messageContent = messageContent
        self.senderUsername = senderUsername
        self.messageSender = messageSender
        self.roomOriginName = roomOriginName
    }
}

```
 
 Here is where the nuance comes in of sending objects over the interconnected webs. Since we are sending a complex object that is composed of more than your average string or integer we are going to have to **encode** our message objects into a JSON representation, so that it can be sent over the web.

 Take a moment to make your Message class in the models folder conform to the codable protocols.

 #### Insert solution box here
 ``` swift
class Message: Codable {
        ...
        private enum CodingKeys: String,CodingKey {
        case messageContent
        case senderUsername
        case messageSender
        case roomOriginName
    }

   required convenience init(from decoder: Decoder) {
        // ACTION: Change these from let to var
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        let messageContent = try? container?.decode(String.self, forKey: .messageContent) ?? ""
        let senderUsername = try? container?.decode(String.self, forKey: .senderUsername) ?? ""
        var messageSender = try? container?.decodeIfPresent(Bool.self, forKey: .messageSender) ?? false
        let roomOriginName = try? container?.decode(String.self, forKey: .roomOriginName) ?? ""
        
        // Force unwrapping may prove to hurt in the future, let's see how we can safely unwrap these values!
        self.init(messageContent: messageContent ?? "", senderUsername: senderUsername ?? "", messageSender: messageSender, roomOriginName: roomOriginName ?? "")
    }
}
 ```

Our event listener in the backend is listening for the chat message event emitter and is expecting a message object to come with it when the event is emitted.
``` javascript
# Code snippet from node backend
socket.on('chat message', function (message) { // Listening for an incoming chat message
        username = getKeyByValue(localStorage, socket.id)
        parsedMessage = JSON.parse(message) // Converts message JSON string into a JSON Object

        console.log("Incoming Message -> ", parsedMessage)
        console.log("Message sent from -> ( ", username, " ", socket.id, ")")
        socket.broadcast.to(parsedMessage.roomOriginName).emit('chat message', message) // Broadcasts message to everyone in the room that the message was sent from except the sender
});

```

Now that we have seen the event listener of the server side lets create an event emitter on our client side to see the intended log statement inside our terminal.

Take a moment to create a method inside our Chat Room class that emits a message event

#### Insert a solution box here
``` swift
    class ChatRoom {
        ...
        func sendMessage(message: Message) {
            
        }
    }
```

Now that we have created our event emitter we need to be able to emit the message object over the network therefore lets put our codable conformance to work!

``` swift
    class ChatRoom {
        ...
        func sendMessage(message: Message) {
            guard let jsonData = try? JSONEncoder().encode(message) else {return} // Have to encode because message object isnt a native json object
            
            self.socket.emit(`"chat message", jsonData)
        }
    }
```


Since we don't have an interface yet for a user to send a message lets trigger it implicitly.
Lets navigate to our RoomsTableViewController.

Inside our create room method ... inside the save action lets formulate a message object to emit

``` swift
...
let saveAction = UIAlertAction(title: "Create/Join Room", style: .default) { (action) in
            guard let roomName = createRoomAlert.textFields?[0].text else {return}
            print("Name of the room user wants to create/join \(roomName)")
            let room = Room(roomName: roomName)
            ChatRoom.shared.room = room
            ChatRoom.shared.joinRoom()
            self.tableView.reloadData()
        }

```

#### Have to refactor when the student builds the chat interface

