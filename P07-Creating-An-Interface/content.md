## Creating a Chat Room Interface

We have finally made it! The last step in our tutorial into making our chat room application. In this portion of the tutorial we are going to be creating our chat interface so we can send and receive messages to and from users!


First lets create a message input view that is in charge of extracting user input and directing it to our controller logic.

Take a moment to create a MessageInputView file inside our views folder!

Here is some started code to create our messaging view

``` swift

class MessageInputView: UIView{
    
    
    // Instantiating text view responsible for typing the message
    let textView = UITextView()
    let sendButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func sendTapped() {
        // Reset the text view when the sender triggers the protocol function
        guard let messsage = textView.text else {return}
        print("User has typed in the message \(String(describing: message))")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = bounds.size
        textView.bounds = CGRect(x: 0, y: 0, width: size.width - 32 - 8 - 60, height: 40)
        sendButton.bounds = CGRect(x: 0, y: 0, width: 60, height: 44)
        
        textView.center = CGPoint(x: textView.bounds.size.width/2.0 + 16, y: bounds.size.height/2.0)
        sendButton.center = CGPoint(x: bounds.size.width - 30 - 16, y: bounds.size.height/2.0)
        
    }
    
    func configureViews() {
        
        // Initalize layout of the the send button and the text view
        backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        textView.layer.cornerRadius = 4
        textView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.6).cgColor
        textView.layer.borderWidth = 1
        
        sendButton.backgroundColor = UIColor(red: 8/255, green: 183/255, blue: 231/255, alpha: 1.0)
        sendButton.layer.cornerRadius = 4
        sendButton.setTitle("Send", for: .normal)
        sendButton.isEnabled = true
        
        sendButton.addTarget(self, action: #selector(MessageInputView.sendTapped), for: .touchUpInside)
        
        addSubview(textView)
        addSubview(sendButton)
    }
}

extension MessageInputView: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
}

```

Now that we have created our view, we need to create a controller that is going to house the logic between our view and our other logic.

Take a moment to create a ChatRoomViewController inside our controllers folder

``` swift
    class ChatRoomViewController: UIViewController {

    let tableView = UITableView() // The messages are going to be organized using a UITableView
    
    // Instantiate the message input view that adds itself as a subview
    let messageInputBar = MessageInputView()
    
    var messages = [Message]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
}

```
We are using a table view to display the messages in rows. In our helpers folder lets **uncomment the logic in layouts.swift**. This file is responsible for boilerplate designing on our chat interface. We will be referencing this file throughout the rest of the tutorial!

Great! Now that we have created a controller that instantiates our message input view lets run it. There is still one small problem though, there is no way to get to this view.

If we go back to our didSelectRowAt method inside our RoomsTableViewController lets add the logic to transition to our ChatRoom.

``` swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoomViewController = ChatRoomViewController()
        self.navigationController?.pushViewController(chatRoomViewController, animated: true)
    }

```

Now try running the program and entering a message ... you should see the print statement that outputs the message that the user wants to send.

Take a break you deserve it! The next step is to notify our controller that the user has sent a message and emit the corresponding event to our server.

To notify our controller that the user pressed send from the Message Input View we need to create a protocol in order to do this.

Take a moment to create a protocol and skeletal function in charge of notifying the controller that the send button was tapped.

#### Insert solution box here
``` swift

// In charge of notifying the controller and relaying the message to be sent over the socket connection!
protocol MessageInputDelegate: class {
    func sendWasTapped(message: String)
}
```

Now that we have created the protocol lets take a moment to add a delegate to our delegator and execute the sendWasTapped method.

#### Insert solution box here
``` swift
     @objc func sendTapped() {
        // Reset the text view when the sender triggers the protocol function
        guard let messsage = textView.text else {return}
        textView.text = "" // Reset the text field after user sends a message
        
        delegate?.sendWasTapped(message: messsage)
    }
```

Now that we have implemented the delegator side of the equation lets make our controller conform to our new protocol. Through separation of concerns lets put this file inside the extensions folder!

``` swift
extension ChatRoomViewController : MessageInputViewDelegate {
        func sendWasTapped(message: String) {
            // In charge of triggering our chat message event emitter and configuring table view to show newly made message
    }
}
```

Did you remember to also mark the receiver of the Chat Room delegate as self?

#### Insert solution box here

``` swift
    class ChatRoomViewController : UIViewController {
        ...
        override func viewWillAppear(_ animated: Bool) {
            ...
            ChatRoom.shared.delegate = self
        }
    }
```

Take a moment to implement trigger our send message method inside our ChatRoom with the given message contents. To do so we need to formulate our message object. 

We currently have a blocker ... we have no access to the room name that the user is currently in!

Take a moment to find a way to transmit the room name from when the user selects the room cell they want to enter to be able to parse the name inside our message object in the ChatRoomViewController.

#### Insert solution box here
``` swift
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoomViewController = ChatRoomViewController()
        chatRoomViewController.roomName = SharedUser.shared.user?.activeRooms?[indexPath.row].roomName ?? "Empty Room"
        self.navigationController?.pushViewController(chatRoomViewController, animated: true)
    }

    class ChatRoomViewController : UIViewController {
        ... 
        var roomName = ""
    }
```

Now that we have access to the last missing attribute inside our message object lets continue to formulate our message object and send it to our chat room logic

Your sendWasTapped method should now look like this

``` swift
    ...
    func sendWasTapped(message: String) {
        let userDefaults = UserDefaults()
        guard let username = userDefaults.value(forKey: "username") else {return}
        print("Sent Message \(message)")
        let messageObject = Message(messageContent: message, senderUsername: username as! String, messageSender: true, roomOriginName: self.roomName)
        ChatRoom.shared.sendMessage(message: messageObject)       
    }
```

Great! Lets run the code now. When you press send it should emit the message event to our server ... but nothing shows up on the screen lets fix that!

First we are going to need to create an array that is going to store our message objects.
Take a moment to add a messages array to our ChatRoomViewController!

``` swift
    class ChatRoomViewController : UIViewController {
        ... 
        var messages = [Message]()
        ...
    }
```

Lets create a new file that is composed of the ChatRoomViewController that conforms to the data source and delegate of the UITableView. Inside extensions lets make a new file called
**ChatRoomViewController+TableViewController.swift**. 

Take a moment to configure this extension to conform to our table view data source and delegate

#### Insert solution box here

``` swift

extension ChatRoomViewController: UITableViewDataSource, UITableViewDelegate {
    // Extension of the ChatRoomView Controller to configure Table View
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of cells corresponding to the number of messages we currently have
        return messages.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    }
    
}
```
Now that we have the proper methods corresponding to our table view lets add some functionality! 

Lets implement a helper method that allows us to insert a message cell into the view without having to reload the table view. For example if every time you sent a message to someone the whole screen reloaded that would get quite annoying!

Lets add the insertNewMessageCell method to our ChatRoomViewController extension.

``` swift

extension ChatRoomViewController: UITableViewDataSource, UITableViewDelegate {
    func insertNewMessageCell(_ message: Message) {
        messages.append(message)
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        
        // Able to do an animation of inserting without needing to reload
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .bottom)
        tableView.endUpdates()
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

```

Great! We are one step closer to visually outputting our messages inside our chat interface!

Now that we have appended that message to our messages array we want to be able to apply those contents to our cell in each row.

To do this we are first going to need to create a custom Table View Cell, I called mine **MessageTableViewCell**. This cell is going to be in charge of displaying our message contents and other corresponding information.

Take a moment to create your Table View Cell. Here is some boilerplate code concerning the layouts of our table view cells