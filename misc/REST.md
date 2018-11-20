You fill out the form on the 'New Newsletter' page and click submit.

Data concerning you, your newsletter content, and any additional information such as media items is sent to the application server.

The server interprets the information, recognizes that the request is for a new newsletter, generates the new record in the database, and performs myriad background tasks (updating the newsletter counter, possibly sending notification emails, etc).

Next, the server sends a response back to the client. This does not necessarily mean that the newsletter was posted. The response could be that there was an error posting or something like that. However, in this case we will say that the newsletter post went through properly, so the server sends a success message and tells the browser which page to go to and render.

Lastly, the browser receives the server information and gives the user feedback. In this case, it shows the user a message saying that their newsletter was successfully posted.
