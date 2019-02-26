Going back to the top-down approach to programming what we have done is already create the visual component that the user is interacting with.

The next step is to add the functionality of actually creating a user. To do this we need to emit or trigger an event on our server to do this event.

[info]
``` javascript
   // Code snippet from this project's backend, can be found in server js


    // After the user connects to the server as we saw in the last page of the tutorial
    socket.on("socketUsername", function (username) {
        console.log(username + " is the username being sent!")
    });
```

To trigger this event we first need to add the Socket IO wrapper written in Swift! This dependency allows us to interact with all the capabilities of Socket IO with methods written in Swift. How amazing is that?!

First let's create a Podfile, a file that lists out the dependencies that are used in the project. If you have familiarity with how a node server operates the Podfile can be thought of a package.json file.

 Execute these sequence of commands in this starter kit directory in terminal.

[action]
```
 pod init // Creates a new podfile
```

Now that we have our podfile lets add the dependency that we want to install, add this command inside your podifle

[action]
```
...
 pod 'Socket.IO-Client-Swift'
```

Once that has been saved to the pod file run 

[action]
```
pod install
```

This command should have added a workspace to your project directory, from now on the code we add to this project will now be done through the workspace. Make sure to open the workspace from this point on!

Now that we created a successful workspace with our Socket IO dependency added lets now navigate to the Chat Room folder that has already been made! You'll see that the ChatRoom.swift file is empty, its our job to write some magic!

First lets import our newly added dependency 

[action]
``` swift
import SocketIO
```

The next step before we can connect to our server is that we have to tell Socket IO to connect to our server running on port 4000! That is the default port that the server is running, this can be changed to a port of your choice.

[action]
``` swift
class ChatRoom {
    port = 4000 // This is your choice

    static let manager = SocketManager(socketURL: URL(string: "http://localhost:\(port)/")!, config: [.log(true), .compress])

    private var socket = manager.defaultSocket // Singleton instance one socket connection per phone.
}
```

1. We are creating an instance our socket manager class that will connect to the given url.

2. We are creating a singleton instance of the socket meaning that there can only be once instance of a socket connection per device! This makes sure that when we are performing operations on or with the socket that it will be the same instance that we have made.


Now that we have created a socket instance that represents the individual connection the user has made to the server, we have to explicitly tell the socket to connect.

Let us add an initalizer to this class, upon initialization of this class we want the first thing our socket to do is connect to our server.

[action]
``` swift
init() {
    // In charge of connecting to the server!
    socket.connect()
}
```

At this point in time we are able to connect but no way to actually execute this code. The approach that we wanted to take was when the user presses the join chat room button in the intial view for this class to be instantiated and the socket connection to be made!

There are **event emitters** and **event listeners** that are used to be able to listen for events and data and respond accordingly.

For example in the code snippet taken from our server at the top of this page, our socket is listening for when a client emits or sends their username and it responds accordingly but logging a statement to the terminal.

As we mentioned earlier this communication can be bi-directional meaning that the server can also emit events that the client is listening for and that is exactly what we are going to do now!


To listen out for events that our server has emitted we can use the on method which listens out for an event when triggered. For example ...


``` swift
socket.on("specificEvent") { (data, ack) in 
    print("Based of this event I want to trigger some functionality")
}
```

1. Here we are able to listen out for a specifc event that is being emitted to the specific socket

We can even listen out for generic events such as connecting, and disconnection ... events that every single socket connection has to perform. Therefore lets create a socket listener using the on method that listens for when a client connects

In the stubbed out function event listeners lets add the event listener for when a socket connects!

#### Have to add solution box for this code snippet
``` swift
socket.on(clientEvent: .connect) { (data, ack) in
    print("User has connected")
} 
```

Since we added our first event listener lets call the function inside this class's initalizer! This is allowing these event listeners to be triggered when the chat room is first instantiated.


Now that we have made our event listener lets finally make a connection to the server. We are going to need to make a view contoller to house the logic between user interactions and our chat room logic

Should be located inside the View Controllers folder~
``` swift
class CreateUserViewController : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

Since our view should only contain logic pertaining to the view let's instatiate the chat room inside our CreateUserViewController 
``` swift
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
``` swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        
        let createUserVC = CreateUserViewController()
        
        window?.rootViewController = UINavigationController(rootViewController: createUserVC)
        return true
    }

```
#### Insert picture of user connecting on terminal

Even though or view is still dark you should see that a user connected output in your terminal

Thats great but our viewController doesn't have a corresponding view ... we now have to instantiate our view and add it as a subview

#### Insert solution box here
``` swift
override func viewDidLoad() {
        super.viewDidLoad()
        let createUserView = CreateUserView()
        createUserView.frame = self.view.bounds
        self.view.addSubview(createUserView)
    }
```

Great now we have a user connected one of the last steps that we have to complete is assiging a username to the socket connection! Therefore to do so we need the username that the user types in, lets head over to our CreateUserView!

Before we move on ... lets introduce the concept of singletons!

Disclaimer: Singletons can often represent poorly architected code due to it allowing global access, therefore a stretch challenge we will implement is a safer and cleaner way to avoid singletons.

Similar to how we only want one instance of a socket connection we also want one instance of our chatroom! Possible errors that can occur if multiple instances of chat rooms are made when we pass values in and throughout the chatroom we may not be altering the intended instance and that can cause unforseen errors!

Inside of our Chat Room class insert the following line of code

``` swift
class ChatRoom {
    static var shared = ChatRoom()
    ...
}
```

The static keyword denotes that the value can be accessed without the instantiation of the class! Now the value we set to shared variable is instantiation of the ChatRoom itself ... wait I'm confused now!

If we make a single instance of the ChatRoom all values altered are in that single instance which is good because we never have to worry about the management of multiple instances! Therefore for any logic relating to the chat room if we access it through the shared variable we can maintain these values!

Lets construct our user object with the typed username, and once we have that we can pass that to our send username method in the ChatRoom file.

``` swift
@IBAction func joinChatRoomButton(_ sender: Any) {
        guard let username = userNameTextField.text else {return}
        let user = User(username: username, activeRooms: nil)
        ChatRoom.shared.sendUsername(user: user)
    }
```

Wait! There is no sendUsername method! Take a minute to implement a method stub called sendUsername.

#### Insert solution box here
``` swift
class ChatRoom {
    ... 
    func sendUsername(user: User) {
       // In charge of emitting an event to server with the passed username 
    }
}
```

This method allows us to send the server an event containing the username as we will see in a moment here!

If we go back to our CreateUserView the error should be gone concerning no method named sendUsername if we passed in the username text, but to fix the error is one thing but to make it work is another!

Lets add some functionality to this sendUsername method in the ChatRoom file!

#### Event Emitters

We have seen the ability to be able to listen to events from our server, but what we wanted to do is trigger an event on our server. Event emitters allow us to ping an event on our server, our first event emitter is going to allow us to send a username to our server and respond back with a message.

If we look back at the code snippet at the start of the file we can see the event listener on the server listening for a username. Our goal is to trigger this event with the corresponding event name. Our server is listening for certain events therefore it's our job to make sure that we name them correctly on both the front-end and the backend.

Take a minute to see if you can emit an event from ours socket

##### Insert solution box here
``` swift
class ChatRoom {
    ...
    func sendUsername(user: User) {
        socket.emit("socketUsername", user.username)
    }
}

```

Great! Now to make sure all this code works, try entering a username and see the corresponding output on your terminal!

The last step that we have to complete is to check if the username that the user has sent is valid. Valid in this context means that no other socket connection has the same username!

On the server side we can see that our event listeners are outputting event emitters.

On the server side the way we are keeping track of this is that we are storing the socket username with the corresponding socket id inside local storage. The goal of this is to be able to check if that username already exists.

``` swift
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
    * If the username already exists within local storage we output that there has been username collision

    * We then create an event emitter that creates an event under the name usernameCollision

 2. If we can't find the username inside local storage then create the key-value pair with the key being the username and the value being the corresponding socket id
    * If the username is valid we then emit an event called valid username

Now that we have an understanding of what the backend is doing behind the scenes when you send a username lets implement custom logic on the client side to respond to these events accordingly.

From the client perspective we are going to be listening out for these two events. Before we start to implement lets go over the desired output of each situation.

When listening for the username collision event handler if triggered we want to display an alert to the user saying that someone connected already has that username

On the other hand when listening for the valid username event handler we want to transition to the next view.

Lets add two event listeners to our Chat Room file, one being for the usernameCollision and the other being for a valid username.

#### Insert solution box here
``` swift 
    func eventListeners() {
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
            userDefaults.set(String(describing: username), forKey: "socketUsername") // Safely cast username as string
        }
    }
```

1. We are printing an error notifying the user if there is a username collision 

2. If the validUsername event handler is triggered we then want to store the username in User Defaults.

As we mentioned earlier if there is a username collision we want to display an alert to the user that they have to re-type their username!

#### Insert link to more info on delegates if need be
#### Introducing delegates!

At this point in time this is assuming you have a basic understanding on how delegates are used to pass information between delegators and delegate receivers but if not feel free to read more on [delegates]()

The delegate we are going to create is going to be in charge of notifying our Chat Room View Controller to display an alert!

To do this we need to create a protocol, navigate over to the protocols file located inside the helpers folder

Take a minute to add a protocol with the skeletal function called transitionToRoom

#### Insert solution box here

#### Change sender and receiver to delegator and delegating object
``` swift
protocol RoomTransition: class {
    func transitionToRoom() {} // Will populate with logic when receiver conforms to protocol
}

protocol UsernameDelegate: class {
    func usernameCollision
}
```

The next step in this process is to create a delegate that our sender is going to trigger! Lets map out what our delegators and and delegate receivers look like.

The sender is going to be the event listener usernameCollision because only at that point in time do we want to display the alert.

The receiver is going to be the CreateUserViewController because once it receives the action it is in charge of displaying the alert.

Take some time to implement the delegate on the sender side and for the receiver to conform to our protocol.

#### Insert solution box
``` swift
    class ChatRoom {
        ... 
        weak var usernameCollisionDelegate : UsernameDelegate?

        func eventListeners() {
            ...
            socket.on("usernameCollision") { (data, ack) in       
            // Trigger our username collision function
            usernameCollisionDelegate?.usernameCollsion()
            }
        }
    }
```

Now that we have implemented our sender lets make our receiver conform to our Room Transition protocol so that when the delegate function is triggered we can respond accordingly.

Take a moment to make our receiver conform to our Room Transition protocol

#### Insert solution box here
``` swift
    class CreateUserViewController : UIViewController, UsernameDelegate {
        ... 
        func usernameCollision() {
        // Creating an alert to display to user if this method is triggered

        let usernameAlert = UIAlertController(title: "Different Username Please", message: "The username you have chosen is already taken by somebody currently connected.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Try Again", style: .cancel, handler: nil)
        usernameAlert.addAction(cancelAction)
        self.present(usernameAlert, animated: true, completion: nil)
        }

        override func viewDidLoad() {

            // Notify the sender that the results should be linked to self(ChatRoomViewController)
            ChatRoom.shared.usernameCollisionDelegate = self
        }
    }
```

To test this functionality if we add two simulators side by side and enter the chat with the same username the second simulator should appear with an alert view asking you to re-type your username!
 * To run two simulators side by side run the project on the iPhone 8 and the iPhone 7

#### Insert GIF of username collision alert happening

We've implemented functionality concerning if two users were to enter the chat with the same username, but what if the user chooses a valid username?

#### Take a moment to execute the same functionality but for our room transition protocol

#### Insert solution box here
```  swift
    class ChatRoom {
        ... 
        weak var roomTransitioDelegate: RoomTransition?

        func eventListeners() {
            ...
            socket.on("validUsername") { (data, ack) in
            
            // Upon a successful username trigger a transtion to the list of active rooms user is currently in
            print("Username has chosen a valid username")
            let username = data[0]
            let userDefaults = UserDefaults()
            userDefaults.set(String(describing: username), forKey: "socketUsername") // Safely cast username as string

            // Notify the sender to transition to the room table view!
            self.roomTransitionDelegate?.transitionToRoom()
        }
        }
    }

    class CreateUserViewController : UIViewController: UsernameDelegate, RoomTransition {
        ...
        func roomTransition() {
            print("User can successfully transition to the next view")
        }

        override func viewDidLoad() {
            ... 
            ChatRoom.shared.roomTransitionDelegate = self
        }
    }
```

This function will be triggered if our event listener for a username collision is triggered! As we can see the flow of communication starts from what the server responds back with initially.


#### Insert picture of output of when the user sends a username

Awesome you have now mirrored interactions between server and client, learned about event emitters and listeners, and one step closer to creating your real time messaging application!

In this section of the tutorial we went over assigning a username to an individual socket connection. Learned to use delegates to either display an alert or transition to the next view. In the next portion we will be able to join and create a room! One step closer to being able to communicate with other users.