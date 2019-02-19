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
#### Insert picutre of user connecting on terminal

Even though or view is still dark you should see that a user connected outputted in your terminal

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

Great now we have a user connected on of the last steps that we have to complete is assiging a username to the socket connection! Therefore to do so we need the username that the user types in, lets head over to our CreateUserView!

Before we move on ... lets introduce the concepts on singletons!

Disclaimer: Singletons can often represent poorly architected code due to it allowing global access, therefore a stretch challenge we will implement a safer and cleaner way to avoid singletons! 

For now we'll honor the red light, green light, refactor methodolgy



Similar to how we only want one instance of a socket connection we also want one instance of our chatroom! Possible errors that can rise if multiple instances of chat rooms are made when we pass values in and throughout the chatroom we may not be altering the intended instance and can cause unforseen errors!

Inside of our Chat Room class insert the following line of code

```
class ChatRoom {
    static var shared = ChatRoom()
    ...
}
```

The static keyword denotes that the value can be accessed without the instantiation of the class! Now the value we set to share is instantiation of the ChatRoom itself ... wait I'm confused now!

If we make a single instance of the ChatRoom all values altered are in that single instance which is good because we never have to worry about the management of multiple instances! Therefore for any logic relating to the chat room if we access it through the shared variable we can maintain these values!

Lets grab a hold of the username that the user types in, once we have that we can pass that to our send username method in the ChatRoom file.

```
@IBAction func joinChatRoomButton(_ sender: Any) {
        guard let username = userNameTextField.text else {return}
        ChatRoom.shared.sendNickname(username: username)
    }
```

Wait! There is no sendUsername method! Take a minute to implement a method stub called sendUsername.

#### Insert solution box here
```
class ChatRoom {
    ... 
    func sendUsername(username: String) {
       // In charge of emitting event to server with the passed username 
    }
}
```

This method allows us to send the server an event containing the username as we will see in a moment here!

If we go back to our CreateUserView the error should be gone concerning no method named sendUsername if we passed in the username text, but to fix the error is one thing but to make it work is another!

Lets add some functionality to this sendUsername method in the ChatRoom file!

#### Event Emitters

We have seen the ability to be able to listen to event from our server, but what is we wanted to trigger an event on our server. Event emitters allow us to ping an event on our server, our first event emitter is going to allow us to send a username to our server and respond back with a functionality!

If we look back at the code snippet at the start of the file we can see the event listener on the server listening for a username! Our goal is to trigger this event with the corresponding event name. Our server  is listening for certain events therefore it's our job to make sure that we emit the correct events that includes naming the event the same on both the front-end and the back-end!

Take a minute to see if you can emit an event from ours socket

##### Insert solution box here
```
class ChatRoom {
    ...
    func sendUsername(username: String) {
        socket.emit("socketUsername", username)
    }
}

```

Great! Now to make sure all this code works, try entering a username and see the corresponding output on your terminal!

The last step that we have to complete is to check if the username that the user has sent is valid. Valid in this context means that no other socket connection has the same username!

On the server side we can see that our event listeners are outputting event emitters 

On the server side the way we are keeping track of this is that we are storing the socket username with the corresponding socket id inside local storage. The goal of this is to be able to check if that username already exists!

```
    # Code snippet taking from the node backend

    socket.on("socketUsername", function (username) {
    
        // Checking if username is already present
        if (localStorage.getItem(username)) {
            console.log("Someone currently connected to the server shares the same username!")
            socket.emit("usernameCollision", username)

        } else { // If we don't see the username
            localStorage.setItem(username, socket.id) // saving the item in local storage

            // Emit that the username chosen because it is a successful username
            socket.emit("validUsername", username)
        }
    });

```
1. The first step taken is to see if the username already exists within local storage
    * If the username already exists within local storage we know that a socket connection with that username already exists

    * If there is a username collision we create an event emitter that creates an event under the name usernameCollision

 2. If we can't find the username inside local storage then create the key-value pair with the key being the username and the value being the corresponding socket id
    * If the username is valid we then create an event emitter to create an event called valid username

Now that we have an understanding what the backend is doing behind the scenes when you send a username lets implement custom logic on the client side to respond to these events accordingly

From the client perspective we are going to be listening out for these two events! Before we start to implement lets go over the desired output of each situation!

When listening for the username collision event handler if triggered we want to display an alert to the user saying that someone connected already has that username

On the other hand when listening for the valid username event handler we want to transition to the next view!

Lets add two event listeners to our Chat Room file, one being for the usernameCollision and the other being for a valid username

#### Insert solution box here
```
    func emittedEvents() {
        ... 
        socket.on("usernameCollision") { (data, ack) in
            print("There has been a username collision, please try a new username")
            
        }
        socket.on("validUsername") { (data, ack) in   
            // Upon a successful username trigger a transtion to the list of active rooms user is currently in
            print("Username has chosen a valid username")

            // Data comes back as type [Any] where the first value is the contents of the data
            let username = data[0]
            let userDefaults = UserDefaults()
            userDefaults.set("socketUsername", forKey: String(describing: username)) // Safely cast username as string
        }
    }
```

1. We are printing an error notifying the user if there is a username collision if the usernameCollision event handler is triggered 

2. If the validUsername event handler is triggered we then weant to store the username in User Defaults so that we are able to access the current user's username in other parts of the application

#### Insert picture of output of when the user sends a username

Awesome you have now mirrored interactions between server and client, learned about event emitters and listeners, and one step closer to creating your real time messaging application!

In this section of the tutorial we went over assigning a username to an individual socket connection! In the next portion we will be able to join and create a room! One step closer to being able to communicate with other users!