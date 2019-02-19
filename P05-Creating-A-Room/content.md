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

