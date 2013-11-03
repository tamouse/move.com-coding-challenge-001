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

- '/' -- delivers the index page in html, compiled from haml.
- '/javascript/photoapp.js' -- delivers the photo application,
  compiled from cofeescript
- '/api/property/:id' -- to emulate the AJAX request to serve the
  property photo collection

### Backbone elements

#### Models

- Thumb -- which takes care of the individual thumbnail images
- Property -- which takes care of the AJAX/JSON processing

#### Collections

- Ticker -- the collection of thumbnail images

#### Views

- ThumbView -- for each thumbnail
- TickerView -- for the ticker strip of thumbnails
- BigImageView -- for the large image
- DescriptionView -- a description area for the large image
- PropertyView -- the property description (currently only contains
  the property id)

### Handling AJAX/JSON 

For this application, 
the JSON returned is not directly applicable to a hierarchy of
Backbone models, collections, and views. I chose to create a special
model, `Propery`, that would deal with the AJAX request and take the
resulting JSON and populate the Ticker collection with Thumb's from
the resulting JSON data.

As an alternative, I think I could have done this as well from inside
the Ticker collection itself, which would have been more cohesive.

The coupling in this design seems a bit much, actually. I think it
should be better separated by making more use of events.

## Front-End Design

I decided to use the [Semantic-UI](http://semantic-ui.com/) user
interface library as it's something new that I have been wanting to
learn. It is an alternative to Twitter Bootstrap, which I have been
using a lot, and I wanted to try something else.

