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

class Message: Codable {
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




1. We are listening for the event emitter called _message_ and with the data passed with that event we are going to print the incoming messages content!

Now that we have seen the event listener of the server side lets create an event emitter on our client side to see the intended log statement inside our terminal!

Take a moment to create a method inside our Chat Room class that emits a message event

#### Insert a solution box here
```
    class ChatRoom {
        ...
        func sendMessage(messageContent: String) {
            socket.emit("message", messageContent)
        }
    }
```

Since we don't have an interface yet for a user to send a message lets create a message stub that we are going to emit from our server

Now that we have made our send message function that is in charge of emitting an event to our server, lets call it! Lets navigate to our RoomsTableViewController

#### Have to refactor when the student builds the chat interface

