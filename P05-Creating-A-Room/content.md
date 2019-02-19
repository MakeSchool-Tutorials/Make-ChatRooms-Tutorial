## Creating/ Joining A Room

In this part of the tutorial we are going to be able to create/join a room! 

Now that we are able to assign a username to a socket connection lets progress to the next feature of the application! 

This is what the end product of this page should look like!

#### Insert gif image of how this flow will look

First lets create our table view that is going to be responsible for displaying all the rooms that the current user is actively in!

Lets create a file in our controllers folder called **RoomsTableViewController**

```
class RoomsTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear() {
        super.viewWillAppear()
    }
}
```

Now that we have created the Rooms Table View file lets add the intended methods that will allow us to make operations on the Table View!

Take a minute to add the delegate and data source methods numberOfRowsInSection, cellForRowAt, didSelectRowAt
#### Insert Solution Box here
```
class RoomsTableViewController: UITableViewController {
    ... 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
}

```

Now that we have these stub methods inserted lets add some functionality to this table view!

We know that there is going to be cells displaying the name of the room therefore lets create a UITableViewCell that is going to be used throughout our UITableViewController

Take a minute to create your table view cell and to register it in the view did load method of our table view controller
#### Add solution box here 
```
class ConfigureCell: UITableViewCell {}

class RoomsTableViewController : UITableViewController {
    ... 
    override func viewDidLoad() {
        // Identifier of the cell is your choice ... remember to stay consistent with the naming of your cell

        tableView.register(ConfigureCell.self, forCellReuseIdentifier: "RoomTableViewCell")
    }
}
```

Now that we have registered our cell lets use it to display some test content until we have actual rooms to show!

If we navigate to our cellForRowAt method this is where we will be configuring our cell to display content! 

Take a minute to dequeue (return) a cell with the same identifier as the cell that we made earlier! 

Insert Solution box here

```
class RoomsTableViewController: UITableViewController {
    ... 
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTableViewCell", for: indexPath)

        // Display test content until we have actual rooms to display!
        cell.textLabel?.text = "Test Room"
        return cell
    }
}
```

Now that we have our cell configured for each row we have not defined how many cells the table view should instantiate! The logic responsible for that is contained inside the numberOfRowsInSection method!

 The number of cells that we want to appear directly corresponds to the number of rooms that the user is actively in! Lets create an array at the top of the file that is used to keep track of the rooms that the user is actively in!

 ```
    class RoomsTableViewController : UITableViewController {

        // Keep track of the room names that the user is in
        var rooms: [String] = [String]()
        ...
         override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rooms.count
        }
    }
 ```

 But we haven't populated our rooms array with anything therefore there are going to be 0 rows instantiated!

 We are now entering the process of creating and joining a room!

 We are first going to need a way to add these rooms! In the GIF above the implemented way is using an alert view to take user input and create the room!

 This is customizable up to your choice whether you would like to use a modal view or another choice!

 First lets create a bar button item that is going to trigger our alert view!

 Take a minute to implement a bar button programatically!

#### Insert solution box here
```
    //     MARK TODO: Can these uielements be extracted to a helper file?

    lazy var createRoomButton: UIBarButtonItem = {
        let createJoinRoomButton = UIBarButtonItem(title: "Create Room", style: .plain, target: self, action: #selector(createRoom(sender:)))
        return createJoinRoomButton
    }()
    
```

Why use the keyword **lazy**?

Lazy is a form of initalization where the object isn't directly created until explicitly told to do so!

We will be adding this button when the view first loads therefore it will be explicitly called in the viewDidLoad method.

Inside the code snippet above the action parameter is set to a method called createRoom wrapped in a selector object! #### Talk more about the selector object

We are going to tie a functionality to this button and that is to display an alert view! 

Lets create a method called createRoom(), dont forget to prefix the method definition with @objc!

Take some time to create an alert view that asks for the room name! Make sure to add save and cancel actions to allow our user to proceed in the application!

#### Insert solution box here
```
     @objc func createRoom(sender: UIBarButtonItem) {
        print("User wants to create a room")
        
        let createRoomAlert = UIAlertController(title: "Enter Room Name", message: "Please enter the name of the room you'd like to join or create!", preferredStyle: .alert)
        createRoomAlert.addTextField { (roomNameTextField) in
            roomNameTextField.placeholder = "Room Name?"
        }
        
        let saveAction = UIAlertAction(title: "Create/Join Room", style: .default) { (action) in
            guard let roomName = createRoomAlert.textFields?[0].text else {return}
            print("Name of the room user wants to create/join \(roomName)")
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("User has canceled the action to create/join a room")
        }
        createRoomAlert.addAction(saveAction)
        createRoomAlert.addAction(cancelAction)
        self.present(createRoomAlert, animated: true, completion: nil)
    }
```
