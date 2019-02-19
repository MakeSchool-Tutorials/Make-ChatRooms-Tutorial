Going back to the top-down approach to programming what we have done is already create the visual component that the user is interacting with !

The next step is to add the functionality of actually creating a user. To do this we need to emit or trigger an event on our server to do ... this event

```
   // Code snippet from this project's backend, can be found in server js


    // After the user connects to the server as we saw in the last page of the tutorial
    socket.on("socketUsername", function (username) {
        console.log(username + " is the username being sent!")
    });
```

To trigger this event we first need to add the Socket IO wrapper written in Swift! This dependency allows us to interact with all the capabilities of Socket IO with methods written in Swift. How amazing is that?!

