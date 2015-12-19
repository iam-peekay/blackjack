# Defines the main app view
class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHands')[0].hit()
    'click .stand-button': ->  @model.get('gameModel').handleFlip()

  initialize: ->
    _.bindAll @
    @render()
    @model.get('gameModel').bind 'gameEnd', @render
    @model.get('gameModel').bind 'splitHand', @render

  render: ->
    @model.get('gameModel').set 'betAmount', parseInt(window.prompt 'How much would you like to bet? 10, 50, 100, or 500?', 10)
    @$el.children().detach()
    @$el.html @template()
    test = @model.get('gameModel').get 'playerHands'
    for hand in test
      @$('.player-hand-container').append new HandView(collection: hand).el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
