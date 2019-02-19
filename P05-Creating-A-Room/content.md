## Creating/ Joining A Room

In this part of the tutorial we are going to be able to create/join a room! 

Now that we are able to assign a username to a socket connection lets progress to the next feature of the application! 

This is what the end product of this page should look like!

#### Insert gif image of how this flow will look

First lets create our table view that is going to be responsible for displaying all the rooms that the current user is actively in!

Lets create a file in our controllers folder called **RoomsTableView**

```
class RoomsTableView: UITableView {
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
class RoomsTableView: UITableView {
    ... 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
}

```