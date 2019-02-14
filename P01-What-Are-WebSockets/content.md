## What are Web Sockets?

This tutorial is centered around the use of socket communication so it is only right that we ask the question ... what are [**web sockets**]()?

A web socket can be thought of as a pipeline that is used to transmit data between client and server. As opposed to a typical http request, when the request is made and resolved the connection doesn't close automatically. The web socket connection remains open to be able to listen and repond to new events.

#### Insert picture of bi directional data flow
With a web socket connection both ends of the connection aka the client and the server can communication with each other. Often named as bi-directional data flow! By allowing data to flow both ways the server and client can equally listen and react to incoming events.

#### Insert picture of multiple clients connecting to server
The server can be thought of as a traffic cop. Their job is to be able to coordinate cars to specific routes and direct them to where they need to be. The server acts in the same way, in charge of coordinating events that come from the multiple clients we may have connected at a time.
#####
If we look at the illustration above when a new client enters we open a connection between the client and the server. All these connections remain open for the purpose of being able to react and listen to oncoming events from other clients, in which the server is in charge of coordinating!
#####
As you progress through the tutorial you will see the direct application of socket communication between client and server!
#####
In the following tutorial we'll be using Socket.io one of the most reliable npm modules on the web that enables node servers to respond to event-driven WebSocket behaviors. Socket.io is a broad and powerful library that can manage multiple channels, rooms, and manage https and other forms of security. In our case we will be implementing a simple asynchronous push of data from the server to the client.