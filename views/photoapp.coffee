Thumb = Backbone.Model.extend
  defaults:
    src: ""
    title: ""
    alt: ""

ThumbView = Backbone.View.extend
  tagName: "img"
  className: "ui image"
  render: ->
    this.$el.attr('src',this.model.attributes.src)
    this.$el.attr('title',this.model.attributes.title)
    this.$el.attr('alt',this.model.attributes.alt)
    this
  
Ticker = Backbone.Collection.extend
  model: Thumb

TickerView = Backbone.View.extend
  el: "#ticker"

  initialize: ->
    this.collection = new Ticker()
    this

  render: ->
    console.log(this)
    this.collection.each((item) ->
      this.renderThumb(item)
    this)

  renderThumb: (item) ->
    thumbView = new ThumbView
      model: item
    console.log(this.$el)
    this.$el.append(thumbView.render().el)
    this


app = new TickerView

thumb = new Thumb
  src: "http://p.rdcpix.com/v02/ld32d4d44-c0s.jpg"
  title: "An Original!"
  alt: "An Original!"

thumbview = new ThumbView({ model : thumb })
thumbview.render()
console.log(thumbview.el)

app.collection.add(thumb)
app.render()
console.log(app.el)
