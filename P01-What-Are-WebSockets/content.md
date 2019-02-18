## What are Web Sockets?

This tutorial is centered around the use of socket communication so it is only right that we ask the question ... what are **web sockets**?

A web socket can be thought of as a pipeline that is used to transmit data between client and server. As opposed to a typical http request, when the request is made and resolved the connection doesn't close automatically. The web socket connection remains open to be able to listen and repond to new events.
#####
[Bi-Directional Communication](./assets/WebSockets-Diagram.png)
#####
1. From the illustration above we can see the first step in establishing this communication is to first execute a handshake which is the initial connection that is made between server and client!

2. Once the connection is opened the data that is able to flow between server and client is Bi-Directional meaning that data can be recieved and emitted from both parties!

3. Unlike typical HTTP requests once the connection is made and the request is resolved the connection does not automatically close. Either end of the socket connection has to explicitly close the socket connection!
#####
With a web socket connection both ends of the connection aka the client and the server can communication with each other. Often named as bi-directional data flow! By allowing data to flow both ways the server and client can equally listen and react to incoming events.
#### 
[Multiple Connected Clients](./assets/ConnectedClients.jpg)
_Forgive the unartistic image!_
####
The server can be thought of as a traffic cop. Their job is to be able to coordinate cars to specific routes and direct them to where they need to be. The server acts in the same way, in charge of coordinating events that come from the multiple clients we may have connected at a time.
#####
If we look at the illustration above when a new client enters we open a connection between the client and the server. All these connections remain open for the purpose of being able to react and listen to oncoming events from other clients, in which the server is in charge of coordinating!
#####
As you progress through the tutorial you will see the direct application of socket communication between client and server!
#####
In the following tutorial we'll be using [Socket.io](https://socket.io/) one of the most reliable npm modules on the web that enables node servers to respond to event-driven WebSocket behaviors. Socket.io is a broad and powerful library that can manage multiple channels, rooms, and manage https and other forms of security. 