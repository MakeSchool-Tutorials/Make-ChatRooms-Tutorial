# It's about that time to start coding! 

Now that we have we a basic understanding of how web sockets work lets proceed to see on in development! If you navigate to this projects backend that can be found [here](https://github.com/Make-School-Labs/Make-ChatRooms-Backend) or in the root README in the installation portion!

Once you have your node server up and running feel free to analyze the source code or a more guided approach as we progress through the tutorial!

The output you should see upon successfully running your node server is this.

#### OUTPUT IMAGE OF SUCCESSUL NODE SERVER RUNNING

Now that we have a functional server up and running lets starting making a functional client to match!

Throughout the development of this project we are going to be using top-down development which in which we build components that the user directly interacts with first and boil down to the implementation details which is our code!

For example if we have view that takes user input and displays it in a label! We will first make the visual components then add the functionality to send that input to the label. This process allows us to map out plans for development by changing your perspective to be that of the user!

The first component of the application is to be able for a user to connect to our server. This in terms of the application itself if is when users first enter the chat and can choose to leave or join a room!

When done with this component our intial screen will look like this!

#### ADD GIF OF THE INTIAL VIEW CONTROLLER SCENE


Since we are adopting a top-down approach lets proceed to making our first xib file that will be in charge of taking the users username and join the chat room!

If you navigate through the starter kit project contained in this project's repo you'll see a views folder. Lets create a new file called **CreateUserView.xib**

Create three components on the view:

1. UIImageView
2. Text Field(Placeholder text optional of "Chat Room Username") 
3. And a button("Text optional of "Join ChatRoom")


If done correctly, it should resemble the GIF up above!

Now that we have created our visual components let us connect that to our code so we can manipulate these elements! Proceed to make the corresponding swift file for our xib view if you haven't done so already!

Once you have created your file for your view the starting contents should look like this *Arrow down

```
    class CreateUserView: UIView {
        override init(frame: CGRect) {
            super.init(frame: frame)
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
```

Inside lets create a function that is in charge of initialzing the view when called from the parent view controller! This allows us to be able to configure this view no matter where its called. Add this function to our View

```
      private func commonInit() {
        
        // When this function is executed it will load the corresponding xib file
        Bundle.main.loadNibNamed("CreateUserView", owner: self, options: nil)

        // Add this view to the main view with added configurations
        addSubview(userInfoView)
        userInfoView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    // Now that we have made this helper function it still has to be executed lets call it in the intializer

     override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }

```

Now that we have the corresponding swift file we can connect our UIElements to code!

