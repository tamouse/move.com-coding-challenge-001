# Coding exercise
# Tamara Temple <tamara@tamaratemple.com>
# Backbone.js Photo Gallery

class Photo extends Backbone.Model
  defaults:
    src: ""
    title: ""
    alt: ""
    original_src: ""

  initialize: ->
    this.set("original_src",this.original_size(this.get("src")))
    this

  original_size: (src) ->
    # This is a constraint of the problem specification.
    # The "original size" image is delivered by the CDN
    # service by substituting and "o" for that last character
    # before the extension.
    src.replace(/(.)\.jpg$/, "o.jpg") 

class PhotoView extends Backbone.View
  tagName: 'img'
  className: "ui image"

  initialize: ->
    this.render()
    this
    
  events:
    'click': 'clicked'
    
  render: ->
    this.$el.attr('src',this.model.get('src'))
    this.$el.attr('title',this.model.get('title'))
    this.$el.attr('alt',this.model.get('alt'))
    this.el
  
  clicked: (event) ->
    Backbone.trigger("show:image", this.model)

class PhotoCollection extends Backbone.Collection
  initialize: ->
    this.update()
    this

  update: ->
    this.set([])                # Since we always get a complete set of images from the server,
                                # we are going to clear out the current set entirely.
    _this = this
    jQuery.ajax
      url: "/api/property/0"    # The service path is arbitrary, just something I made up.
    .done (data) ->
      _this.data = data
      _this.convert()
    this

  convert: ->
    console.log("converting...")
    this.property_id = this.data.property_id
    _.each(this.data.photos,
      (item) ->
        this.add(new Photo
          src: item.href
          title: item.description
          alt: item.description
        )
      , this  
    )
    this.trigger('photos:converted',this)
    this

class ImageView extends Backbone.View
  el: '#image'
  template: _.template('<img class="ui image" id="bigimage" src="<%= original_src %>" alt="<%= alt %>" title="<%= title %>" /><p class="ui center aligned basic segment" id="description"><%= title %></p>')

  initialize: ->
    if (!this.collection)
      throw new Error("ImageView requires a collection")
    this.listenTo(this.collection,'photos:converted',this.firstPhoto)
    Backbone.on("show:image",this.showClicked,this)
    
    this
    
  render: ->
    console.log("Rendering Image")
    this.$el.html(this.template(this.showing.attributes))
    this

  firstPhoto: ->
    this.showClicked(this.collection.models[0])

  showClicked: (model) ->
    this.showing = model
    this.render()



class TickerView extends Backbone.View
  el: "#ticker"
  initialize: ->
    if (!this.collection)
      throw new Error("TickerView requires a collection")
    this.listenTo(this.collection,'add',this.add)
  add: (model, collection) ->
    model.view = new PhotoView
      model: model
    this.$el.append( model.view.el )
  render: ->
    console.log("Rendering Ticker")
    this
    
class AppView extends Backbone.View
  el: $('#property-id')
  initialize: ->
    this.collection = new PhotoCollection
    options = { collection: this.collection }
    this.viewer = new ImageView(options)
    this.ticker = new TickerView(options)
    this.listenTo(this.collection,'photos:converted',this.render)

    this
    
  render: ->
    console.log("Rendering App")
    this.viewer.render()
    this.ticker.render()
    this.$el.text(this.collection.property_id)


window.photoGallery = new AppView
