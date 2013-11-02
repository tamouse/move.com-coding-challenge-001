class Thumb extends Backbone.Model
  defaults:
    src: ""
    title: ""
    alt: ""

  initialize: ->
    this.set("original_src",this.original_size())

  original_size: ->
    current_src = this.get("src")
    current_src.replace(/(.)\.jpg/, "o.jpg")

class ThumbView extends Backbone.View
  tagName: "img"
  className: "ui image"

  events:
    'click': 'clicked'
    
  render: ->
    this.$el.attr('src',this.model.get('src'))
    this.$el.attr('title',this.model.get('title'))
    this.$el.attr('alt',this.model.get('alt'))
    this
  
  clicked: (event) ->
    Backbone.trigger("show:image", this.model)


class Ticker extends Backbone.Collection
  model: Thumb

class TickerView extends Backbone.View
  el: "#ticker"

  initialize: ->
    this.collection = new Ticker()
    this

  render: ->
    this.collection.each((item) ->
      this.renderThumb(item)
    this)

  renderThumb: (item) ->
    thumbView = new ThumbView
      model: item
    this.$el.append(thumbView.render().el)
    this

class BigImageView extends Backbone.View
  el: '#bigimage'

  initialize: ->
    Backbone.on("show:image", this.changeImage, this)

  changeImage: (model) ->
    this.$el.attr('src',model.get('original_src'))

  render: ->
    this.changeImage(app.collection[0])
    this.$el.attr('title',model.get('title'))
    this.$el.attr('alt',model.get('alt'))
  

class DescriptionView extends Backbone.View
  el: '#description'
  initialize: ->
    Backbone.on("show:image", this.changeDescription, this)
  changeDescription: (model) ->
    if (model.get("title").length > 0)
      this.$el.text(model.get("title"))
    else
      this.$el.html("&nbsp;")

  render: ->
    this.changeDescription(app.collection.at(0))


class Property extends Backbone.Model
  defaults:
    property_id: 0
    photos: []

  urlRoot: "/api/property"

  fillTicker: (prop, app) ->
    _.each(prop.get("photos"), (item) ->
      app.collection.add(new Thumb
        src: item.href
        title: item.description
        alt: item.description
      )
    )
    app.render()
    Backbone.trigger("show:image", app.collection.at(0))
    app

    
app = new TickerView

bigimg = new BigImageView

description = new DescriptionView

prop = new Property
  id: 17

prop.fetch
  success: ->
    prop.fillTicker(prop, app)



