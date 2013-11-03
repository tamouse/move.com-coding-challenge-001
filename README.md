# Coding exercise for Move.com

Set an exercise to display a photo gallery of a typical property, I
decided to approach it using [Backbone.js](http://backbonejs.org) for
the application framework on the client, the concept being that the
photo gallery should be able to receive JSON as if from an AJAX
request and populate the gallery appropriately.

There (hopefully) is a demo running at
[photos.tamouse.org](http://photos.tamouse.org).

## Install

Clone or copy the repository:

    $ git clone https://github.com/tamouse/move.com-coding-challenge-001.git photos

Run bundler to make sure all dependencies are there:

    $ bundle install

Start up the application:

    $ ruby sinapp.rb

This will launch the server on port 9201. Open a browser window to
`http://localhost:9201` and you should see the application.

## Architecture Considerations

I decided to go with a [Sinatra](http://sinatrarb.com) application
server for this, primarily for the utter simplicity. The server only
has a few routes:

- '/' -- delivers the gallery in a vertical format (thumbnails below
  larger image)
- '/2' -- delivers the gallery in a horizontal format (thumbnails to
  the right of the larger image)
- '/readme' -- this file
- '/javascript/photoapp.js' -- delivers the photo application,
  compiled from cofeescript
- '/api/property/:id' -- to emulate the AJAX request to serve the
  property photo collection

### Backbone elements

As with most Backbone applications, it starts with an Application
View, which keeps track of the other main objects in the system,
starting things up, and keeping things going.

`AppView` contains the `PhotoCollection` which is the image
information retrieved from the AJAX call. It also instantiates two
other views, `ImageView` and `TickerView`:

- `ImageView` manages the large, "hero" unit view of the gallery. This
  is the currently selected image in the gallery.

- `TickerView` manages the thumbnail display.

Additionally, `Photo` is the model for holding the thumbnail picture
elements, and `PhotoView` is the view that shows them.

### Handling AJAX/JSON 

For this application, the JSON returned is not directly applicable to
a hierarchy of Backbone models, collections, and views.

`PhotoCollection` has the method `update`, which performs an AJAX call
to the Sinatra server, which returns the JSON data (as was supplied).

The photos array from the returned data is used to populate the
collection by creating new `Photo` models and adding them to the
collection.


## Front-End Design

I decided to use the [Semantic-UI](http://semantic-ui.com/) user
interface library as it's something new that I have been wanting to
learn. It is an alternative to Twitter Bootstrap, which I have been
using a lot, and I wanted to try something else.

I was not sure whether a vertical or horizontal arrangement would be
more pleasing, so I made both.


*******

- *Author:* Tamara Temple <tamara@tamaratemple.com>
- *Copyright:* Tamara Temple
- *License:* MIT
- Images copyright Move.com.
- *Github:* https://github.com/tamouse/move.com-coding-challenge-001

