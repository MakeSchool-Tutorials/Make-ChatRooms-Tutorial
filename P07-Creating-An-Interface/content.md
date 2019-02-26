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

