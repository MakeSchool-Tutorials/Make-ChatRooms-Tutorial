## Making Models

We are entering a state of the application where more information needs to be stored corresponding to our objects! 

Right now there is no relation between our users and their rooms other than the sequence of our views! Lets take a moment to model a relationship between our users and rooms!

The relationship between users and rooms ... drumroll please ... a one to many relationship! Meaning that one user cann n participate in many chatrooms!

Knowing this can better help us when creating a model for our objects!

Take a moment to implement a user class with their corresponding attributes!

#### Insert a solution box here
```
    class User {
        var username: String
        var activeRooms : [Room]

        init(username: String, activeRooms: [Room]) {
            self.username = username
            self.activeRooms = activeRooms
        }
    }
```

1. The username attribute to identify user.

2. An array of rooms that the user is actively in, models the one to many relationship.

3. Initalizing every instance of this class with these two attributes!


This is what we call modeling our domain! We are taking real world attributes of this object and representing it in a object allowing us to manipulate and operate on thesse attributes!

Now that we have modeled the user lets take a moment to see what modeling our Room object would look like?

Can you think of what other attributes can be useful towards our Room object?

Lets start of with the attribute we know we'll need, the room Name!

Take a moment to implement our room model

#### Insert a solution box here
```
    class Room {
        var roomName : String

        init(roomName: string) {
            self.roomName = roomName
        }
    }
```

Congrats you have modeled the domain for two objects that we have been working with thus far!

#### Should they refactor previous code to  be able to pass the object as oppose to the value for the attribute (username and room name)?
