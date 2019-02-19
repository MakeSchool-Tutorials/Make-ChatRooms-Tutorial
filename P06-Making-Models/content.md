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