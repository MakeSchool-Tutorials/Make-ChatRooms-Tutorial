## Sending a Message

Now that we are able to join a room on our server lets start working on the ability to message other users in that room! 

Disclaimer: The node server that has been running is listening for a chat message event, the problem is that it is looking for a message object after we create our message model! For this first step we want to be able to just emit a message to the server.

This listener has been created on the server side to listen for just the message, later on in the tutorial we will refactor to send the whole message object!

```
    # Code snippet taken from the node server that we've created!

    socket.on("message", function(messageContent) {
        console.log("Incoming message contents : ", messageContent)
    });
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

