## Making Models

We are entering a state of the application where information needs to be stored corresponding to our objects.

It's time to start modeling our domain, or listing out key attributes that will represent our user.

Take some time to think about some attributes that our user will have.

[solution]
``` swift
    class User {
        var username: String
        var activeRooms : [Room]? 

        init(username: String, activeRooms: [Room]?) {
            self.username = username
            self.activeRooms = activeRooms
        }
    }
```

1. The username attribute to identify user.
######
2. An array of rooms that the user is actively in, models the one to many relationship.
    - You will get an error saying that Room is undefined that will be the next object we model.
    - Lets make the activeRooms attribute optional because when the user first joins the chat they are not going to be in any rooms.
######
3. Initalizing every instance of this class with these two attributes.

Now that we have modeled the user lets take a moment to see what modeling our Room object would look like?

Can you think of what other attributes can be useful towards our Room object?

Lets start of with the attribute we know we'll need, the room Name!

Take a moment to implement our room model

[solution]
``` swift
    class Room {
        var roomName : String

        init(roomName: String) {
            self.roomName = roomName
        }
    }
```

Disclaimer: Singletons can often represent poorly architected code due to it allowing global access, therefore a stretch challenge we will implement is a safer and cleaner way to avoid singletons.

When altering the number of active rooms that a user has we want to make sure that we alter the same user instance throughout the application. There will a stretch challenge at the end of this tutorial to refactor the use of singletons to use something safer to maintain access to our object throughout the application.

Lets make a singleton of our user! Take a moment to create a file called SharedUser.swift

[action]
``` swift
import Foundation
class SharedUser {
    static var shared = SharedUser()
    var user: User?
}
```

From now on when referencing our current user we will be doing so through are shared user instance!

Congrats you have modeled the domain for two objects that we have been working with thus far!


In the next page of the tutorial we are going to using our users 
#### Should they refactor previous code to  be able to pass the object as oppose to the value for the attribute (username and room name)?
