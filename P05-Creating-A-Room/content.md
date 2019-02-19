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