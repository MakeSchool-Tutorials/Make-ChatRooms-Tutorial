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

