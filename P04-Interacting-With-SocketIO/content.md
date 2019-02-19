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

First let's create a Podfile, a file that lists out the dependencies to are used in the project. If you have familiarity with how a node server operates the Podfile can be thought of a package.json file!

 Execute these sequence of commands in this starter kit directory in terminal

```
 pod init // Creates a new podfile
```

Now that we have our podfile lets add the dependency that we want to install, add this command inside your podifle

```
...
 pod 'Socket.IO-Client-Swift'
```

Once that has been saved to the pod file run 

```
pod install
```

This command should have added a workspace to your project directory, from now on the code we add to this project will now be done through the workspace. Make sure to open the workspace from this point on!

Now that we created a successful workspace with our Socket IO dependency added lets now navigate to the Chat Room folder that has already been made! You'll see that the ChatRoom.swift file is empty, its our job to write some magic!

First lets import our newly added dependency 

```
import SocketIO
```

The next step before we can connect to our server is that we have to tell Socket IO to connect to our server running on port 4000! That is the default port that the server is running, this can be changed to a port of your choice

```
class ChatRoom {
    port = 4000 // This is your choice

    static let manager = SocketManager(socketURL: URL(string: "http://localhost:\(port)/")!, config: [.log(true), .compress])

    private var socket = manager.defaultSocket // Singleton instance  one socket connection per phone
}
```

1. We are creating a socket manager in charge of connecting to the given url

2. We are creating a singleton instance of the socket meaning that there can only be once instance of a socket connection per device! This makes sure that when we are performing operations on or with the socket that it will continuosly be the same instance that we have made!


