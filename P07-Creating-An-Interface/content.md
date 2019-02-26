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
