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

2. We are creating a singleton instance of the socket meaning that there can only be once instance of a socket connection per device! This makes sure that when we are performing operations on or with the socket that it will be the same instance that we have made!


Now that we have created a socket instance that represents the individual connection the user has made to the server we have to explicitly tell the socket to connect

Let us add an initalizer to this class, upon initialization of this class we want the first thing to happen is for the socket connection to be made to the server

```
init() {
    // In charge of connecting to the server!
    socket.connect()
}
```

At this point in time we are able to connect but no way to actually execute this code. The approach that we wanted to take was when the user presses the join chat room button in the intial view for this class to be instantiated and the socket connection to be made!

### Have to refactor this portion right here and make it more semantic

The problem is that the view has no parent view controller which is lays at the top of our logic hierarchy. In charge of controlling the interactions between our client, view, and chat room logic. By the end of this page you'll will have fully a controller that has defined the flow of logic from when our user first taps join chat room with their username and making the connection to our server


Before we do so we should highlight the communication between server and client that is going to be taking place!

There are **event emitters** and **event listeners** that are used to be able to listen for events and data and respond accordingly!

For example in the code snippet taken from our server our socket is listening for when a the client emits or sends their username and it responds accordingly but logging a statement to the terminal.

As we mentioned earlier this communication can be bi-directional meaning that the server can also emit and event that the client is listening for and that is exactly what we are going to do now!

```

```


#### After the portion above has been written lets make the controller because all they need is the first event emitters and then they can execute the logic

To listen out for events that our server has emitted we can use the on method which given an event is triggered when that event comes back! For example

```
socket.on("specificEvent") { (data, ack)
    print("Based of this event I want to trigger some functionality")
}
```

1. Here we are able to listen out for a specifc event that is being emitted to the specific socket

We can even listen out for generic events such as connecting, and disconnection ... events that every single socket connection has to perform! Therefore lets create a socket listener using the on method that listens for when a client connects

In the stubbed out function event listeners lets add the event listener for when a socket connects!

#### Have to add solution box for this code snippet
```
socket.on(clientEvent: .connect) { (data, ack)
    print("User has connected")
} 
```

Since we add our first event listener let's call the event listeners function inside this class's initalizer! This is allowing these event listeners to be triggered when the chat room is first instantiated!


Now that we have made our event listener lets finally make a connection to the server! We are going to need to make a view contoller to house the logic between user interactions and our chat room logic

Should be located inside the View Controllers folder~
```
class CreateUserViewController : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

Since our view should only contain logic pertaining to the view let's instatiate the chat room inside our CreateUserViewController that we made

```
class CreateUserViewController : UIViewController {
    let chatRoom = ChatRoom() // Upon initialization the socket will make a connection

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

Great! Lets now run the program ... oh shoot there is a black screen!

#### Insert the screen black simulator
The reason being is that we haven't set our root view controller, take a minute to set our root view controller to be the CreateUserViewController

#### Insert the solution box 
```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        
        let createUserVC = CreateUserViewController()
        
        window?.rootViewController = UINavigationController(rootViewController: createUserVC)
        return true
    }

```

Thats great but our viewController doesn't have a corresponding view ... we now have to instantiate our view and add it as a subview

#### Insert solution box here
```
override func viewDidLoad() {
        super.viewDidLoad()
        let createUserView = CreateUserView()
        createUserView.frame = self.view.bounds
        self.view.addSubview(createUserView)
    }
```

#### How do we introduce the concepts on singletons